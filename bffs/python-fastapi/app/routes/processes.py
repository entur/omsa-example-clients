import logging

from fastapi import APIRouter, Depends, Response

from ..clients.omsa import OMSAClient
from ..config import Settings
from ..dependencies import get_app_settings, get_offer_cache, get_omsa_client
from ..models import (
    ConfirmPackageRequest,
    PurchaseOffersRequest,
    SearchOfferRequest,
)
from ..services.cache import OfferCache

logger = logging.getLogger(__name__)

router = APIRouter(prefix=f"{Settings().api_base_path}/processes", tags=["processes"])


@router.post("/search-offers/execute")
async def search_offers(
    search_request: SearchOfferRequest,
    response: Response,
    settings: Settings = Depends(get_app_settings),
    cache: OfferCache = Depends(get_offer_cache),
    client: OMSAClient = Depends(get_omsa_client),
):
    """Proxy OMSA offer search with lightweight caching."""

    payload = search_request.cache_payload()
    cache_key = OfferCache.build_cache_key(payload)

    cached_entry = await cache.get(cache_key)
    if cached_entry:
        response.headers["x-cache-hit"] = "true"
        response.headers["x-cache-source"] = cached_entry.source
        response.headers["x-omsa-mode"] = settings.omsa_mode
        return cached_entry.data

    offers = await client.search_offers(search_request)

    source_label = "omsa-local" if settings.omsa_mode == "local" else "omsa-remote"
    await cache.set(cache_key, offers, source=source_label)
    response.headers["x-cache-hit"] = "false"
    response.headers["x-omsa-mode"] = settings.omsa_mode
    return offers


@router.post("/purchase-offers/execute")
async def purchase_offers(
    purchase_request: PurchaseOffersRequest,
    client: OMSAClient = Depends(get_omsa_client),
):
    return await client.purchase_offers(
        purchase_request.model_dump(by_alias=True, exclude_none=True, mode="json")
    )


@router.post("/confirm-package/execute")
async def confirm_package(
    confirm_request: ConfirmPackageRequest,
    client: OMSAClient = Depends(get_omsa_client),
):
    dumped = confirm_request.model_dump(by_alias=True, exclude_none=True, mode="json")
    logger.debug("Confirming package: %s", dumped.get("inputs", {}).get("packageId"))
    return await client.confirm_package(dumped)


@router.get("/refund-options/items")
async def get_refund_options(
    packageId: str,
    client: OMSAClient = Depends(get_omsa_client),
):
    return await client.get_refund_options(packageId)


@router.get("/change-options/items")
async def get_change_options(
    packageId: str,
    client: OMSAClient = Depends(get_omsa_client),
):
    return await client.get_change_options(packageId)
