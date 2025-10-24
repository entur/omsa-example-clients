from fastapi import Request
from httpx import AsyncClient

from .config import Settings, get_settings
from .services.cache import OfferCache


def get_app_settings() -> Settings:
    return get_settings()


def get_http_client(request: Request) -> AsyncClient:
    return request.app.state.http_client  # type: ignore[attr-defined]


def get_offer_cache(request: Request) -> OfferCache:
    return request.app.state.offer_cache  # type: ignore[attr-defined]
