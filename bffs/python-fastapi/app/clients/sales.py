from __future__ import annotations

from typing import Any, Dict

import httpx
from fastapi import HTTPException, status

from ..config import Settings
from .omsa import OAuthTokenManager


class SalesClient:
    """HTTP client for Entur Sales (payments) API."""

    def __init__(self, client: httpx.AsyncClient, settings: Settings) -> None:
        self._client = client
        self._settings = settings
        self._token_manager = OAuthTokenManager(settings)

    @property
    def base_url(self) -> str:
        return self._settings.sales_base_url.rstrip("/")

    async def _authorized_headers(self) -> Dict[str, str]:
        token = await self._token_manager.get_token(self._client)
        return {
            "Authorization": token.authorization_header,
            "Accept": "application/hal+json",
            "Accept-Language": "en-GB",
        }

    def _entur_headers(self) -> Dict[str, str]:
        return self._settings.entur_headers

    def _handle_response(self, response: httpx.Response, action: str) -> Dict[str, Any]:
        try:
            response.raise_for_status()
        except httpx.HTTPStatusError as exc:
            raise HTTPException(
                status_code=status.HTTP_502_BAD_GATEWAY,
                detail=f"Failed to {action}: {exc.response.text}",
            ) from exc
        return response.json() if response.content else {}

    async def create_payment(self, body: Dict[str, Any]) -> Dict[str, Any]:
        response = await self._client.post(
            f"{self.base_url}/payments",
            json=body,
            headers={
                **await self._authorized_headers(),
                **self._entur_headers(),
                "Content-Type": "application/json",
            },
        )
        return self._handle_response(response, "create payment")

    async def start_terminal_session(
        self, payment_id: str, transaction_id: str, body: Dict[str, Any]
    ) -> Dict[str, Any]:
        response = await self._client.post(
            f"{self.base_url}/payments/{payment_id}/transactions/{transaction_id}/terminal",
            json=body,
            headers={
                **await self._authorized_headers(),
                **self._entur_headers(),
                "Content-Type": "application/json",
            },
        )
        return self._handle_response(response, "start terminal session")

    async def start_app_claim_session(
        self, payment_id: str, transaction_id: str, body: Dict[str, Any]
    ) -> Dict[str, Any]:
        response = await self._client.post(
            f"{self.base_url}/payments/{payment_id}/transactions/{transaction_id}/app-claim",
            json=body,
            headers={
                **await self._authorized_headers(),
                **self._entur_headers(),
                "Content-Type": "application/json",
            },
        )
        return self._handle_response(response, "start app-claim session")

    async def capture_transaction(
        self, payment_id: str, transaction_id: str
    ) -> Dict[str, Any]:
        response = await self._client.put(
            f"{self.base_url}/payments/{payment_id}/transactions/{transaction_id}/capture",
            headers={
                **await self._authorized_headers(),
                **self._entur_headers(),
            },
        )
        return self._handle_response(response, "capture transaction")

    async def get_transaction(
        self, payment_id: str, transaction_id: str
    ) -> Dict[str, Any]:
        response = await self._client.get(
            f"{self.base_url}/payments/{payment_id}/transactions/{transaction_id}",
            headers={
                **await self._authorized_headers(),
                **self._entur_headers(),
            },
        )
        return self._handle_response(response, "get transaction")
