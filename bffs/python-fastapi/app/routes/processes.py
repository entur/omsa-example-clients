from fastapi import APIRouter, Depends, Response

from ..clients.omsa import OMSAClient
from ..config import Settings
from ..dependencies import get_app_settings, get_http_client, get_offer_cache
from ..models import (
    ConfirmPackageRequest,
    PurchaseOffersRequest,
    SearchOfferRequest,
)
from ..services.cache import OfferCache

router = APIRouter(prefix="/api/v1/processes", tags=["processes"])


@router.post("/search-offers/execute")
async def search_offers(
    search_request: SearchOfferRequest,
    response: Response,
    settings: Settings = Depends(get_app_settings),
    cache: OfferCache = Depends(get_offer_cache),
    http_client=Depends(get_http_client),
):
    """Proxy OMSA offer search with lightweight caching."""

    payload = search_request.cache_payload()
    cache_key = OfferCache.build_cache_key(payload)

    cached_entry = await cache.get(cache_key)
    if cached_entry:
        response.headers["x-cache-hit"] = "true"
        response.headers["x-cache-source"] = cached_entry.source
        response.headers["x-omsa-mode"] = settings.omsa_mode
        response.headers["x-omsa-base-url"] = settings.resolved_omsa_base_url
        return cached_entry.data

    client = OMSAClient(http_client, settings)
    offers = await client.search_offers(search_request)

    source_label = "omsa-local" if settings.omsa_mode == "local" else "omsa-remote"
    await cache.set(cache_key, offers, source=source_label)
    response.headers["x-cache-hit"] = "false"
    response.headers["x-omsa-mode"] = settings.omsa_mode
    response.headers["x-omsa-base-url"] = settings.resolved_omsa_base_url
    return offers


@router.post("/purchase-offers/execute")
async def purchase_offers(
    purchase_request: PurchaseOffersRequest,
    settings: Settings = Depends(get_app_settings),
    http_client=Depends(get_http_client),
):
    client = OMSAClient(http_client, settings)
    return await client.purchase_offers(
        purchase_request.model_dump(by_alias=True, exclude_none=True)
    )


@router.post("/confirm-package/execute")
async def confirm_package(
    confirm_request: ConfirmPackageRequest,
    settings: Settings = Depends(get_app_settings),
    http_client=Depends(get_http_client),
):
    client = OMSAClient(http_client, settings)
    return await client.confirm_package(
        confirm_request.model_dump(by_alias=True, exclude_none=True)
    )
