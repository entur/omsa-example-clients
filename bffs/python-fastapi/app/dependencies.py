from fastapi import Request
from httpx import AsyncClient

from .config import Settings, get_settings
from .services.cache import OfferCache


def get_app_settings() -> Settings:
    """Expose Settings through FastAPI dependency injection."""

    return get_settings()


def get_http_client(request: Request) -> AsyncClient:
    """Return the shared AsyncClient attached to the application state."""

    return request.app.state.http_client  # type: ignore[attr-defined]


def get_offer_cache(request: Request) -> OfferCache:
    """Return the shared OfferCache instance."""

    return request.app.state.offer_cache  # type: ignore[attr-defined]
