from fastapi import Request
from httpx import AsyncClient

from .clients.omsa import OMSAClient
from .clients.sales import SalesClient
from .config import Settings, get_settings
from .services.cache import OfferCache


def get_app_settings() -> Settings:
    return get_settings()


def get_http_client(request: Request) -> AsyncClient:
    return request.app.state.http_client  # type: ignore[attr-defined]


def get_offer_cache(request: Request) -> OfferCache:
    return request.app.state.offer_cache  # type: ignore[attr-defined]


def get_omsa_client(request: Request) -> OMSAClient:
    return request.app.state.omsa_client  # type: ignore[attr-defined]


def get_sales_client(request: Request) -> SalesClient:
    return request.app.state.sales_client  # type: ignore[attr-defined]
