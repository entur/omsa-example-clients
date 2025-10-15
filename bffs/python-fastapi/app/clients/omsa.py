from __future__ import annotations

import asyncio
from dataclasses import dataclass
from datetime import UTC, datetime, timedelta
from typing import Any, Dict

import httpx
from fastapi import HTTPException, status

from ..config import Settings
from ..models.search import SearchOfferRequest


@dataclass
class OAuthToken:
    access_token: str
    token_type: str
    expires_at: datetime

    @property
    def authorization_header(self) -> str:
        return f"{self.token_type} {self.access_token}"

    def is_expired(self) -> bool:
        # Refresh five minutes before actual expiry to be safe.
        safety_window = timedelta(minutes=5)
        return datetime.now(tz=UTC) >= self.expires_at - safety_window


class OAuthTokenManager:
    """Manage Entur OAuth tokens with concurrency-aware refresh logic."""

    def __init__(self, settings: Settings) -> None:
        self._settings = settings
        self._token: OAuthToken | None = None
        self._lock = asyncio.Lock()

    async def get_token(self, client: httpx.AsyncClient) -> OAuthToken:
        async with self._lock:
            if self._token is None or self._token.is_expired():
                self._token = await self._refresh_token(client)
            return self._token

    async def _refresh_token(self, client: httpx.AsyncClient) -> OAuthToken:
        if not self._settings.client_id or not self._settings.client_secret:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail="OMSA credentials are not configured on the BFF.",
            )

        response = await client.post(
            self._settings.oauth_token_url,
            data={
                "grant_type": "client_credentials",
                "client_id": self._settings.client_id,
                "client_secret": self._settings.client_secret,
                "audience": self._settings.auth_audience,
            },
            headers={
                "Accept": "application/json",
                "Content-Type": "application/x-www-form-urlencoded",
            },
            timeout=client.timeout,
        )

        try:
            response.raise_for_status()
        except httpx.HTTPStatusError as exc:
            raise HTTPException(
                status_code=status.HTTP_502_BAD_GATEWAY,
                detail=f"Failed to obtain OAuth token: {exc.response.text}",
            ) from exc

        body = response.json()
        expires_in = int(body.get("expires_in", 3600))
        expires_at = datetime.now(tz=UTC) + timedelta(seconds=expires_in)
        return OAuthToken(
            access_token=body["access_token"],
            token_type=body.get("token_type", "Bearer"),
            expires_at=expires_at,
        )


class OMSAClient:
    """Typed HTTP client for interacting with the OMSA API."""

    def __init__(self, client: httpx.AsyncClient, settings: Settings) -> None:
        self._client = client
        self._settings = settings
        self._token_manager = OAuthTokenManager(settings)

    @property
    def base_url(self) -> str:
        return self._settings.resolved_omsa_base_url

    async def _authorized_headers(self) -> Dict[str, str]:
        token = await self._token_manager.get_token(self._client)
        return {
            "Authorization": token.authorization_header,
            "Accept": "application/json",
        }

    def _entur_headers(self) -> Dict[str, str]:
        return self._settings.entur_headers

    async def search_offers(self, request: SearchOfferRequest) -> Dict[str, Any]:
        payload = request.model_dump(by_alias=True, exclude_none=True, mode="json")
        response = await self._client.post(
            f"{self.base_url}/processes/search-offers/execute",
            json=payload,
            headers={
                **await self._authorized_headers(),
                **self._entur_headers(),
                "Content-Type": "application/json",
                "Accept-Language": "en-GB",
            },
        )
        return self._handle_response(response, "search offers")

    async def purchase_offers(self, body: Dict[str, Any]) -> Dict[str, Any]:
        response = await self._client.post(
            f"{self.base_url}/processes/purchase-offers/execute",
            json=self._ensure_json(body),
            headers={
                **await self._authorized_headers(),
                **self._entur_headers(),
                "Content-Type": "application/json",
                "Accept-Language": "en-GB",
            },
        )
        return self._handle_response(response, "purchase offers")

    async def confirm_package(self, body: Dict[str, Any]) -> Dict[str, Any]:
        response = await self._client.post(
            f"{self.base_url}/processes/confirm-package/execute",
            json=self._ensure_json(body),
            headers={
                **await self._authorized_headers(),
                **self._entur_headers(),
                "Content-Type": "application/json",
                "Accept-Language": "en-GB",
            },
        )
        return self._handle_response(response, "confirm package")

    async def get_travel_documents(self, package_id: str) -> Dict[str, Any]:
        response = await self._client.get(
            f"{self.base_url}/collections/travel-documents/items",
            params={"packageId": package_id},
            headers={
                **await self._authorized_headers(),
                **self._entur_headers(),
                "Accept": "application/json",
                "Accept-Language": "en-GB",
            },
        )
        return self._handle_response(response, "get travel documents")

    @staticmethod
    def _ensure_json(data: Dict[str, Any]) -> Dict[str, Any]:
        def convert(value):
            if isinstance(value, datetime):
                return value.isoformat()
            if isinstance(value, list):
                return [convert(item) for item in value]
            if isinstance(value, dict):
                return {key: convert(val) for key, val in value.items()}
            return value

        return convert(data)

    def _handle_response(
        self, response: httpx.Response, action: str
    ) -> Dict[str, Any]:
        try:
            response.raise_for_status()
        except httpx.HTTPStatusError as exc:
            raise HTTPException(
                status_code=status.HTTP_502_BAD_GATEWAY,
                detail=f"Failed to {action}: {exc.response.text}",
            ) from exc
        return response.json()
