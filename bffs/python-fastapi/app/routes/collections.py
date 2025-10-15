from fastapi import APIRouter, Depends, Query

from ..clients.omsa import OMSAClient
from ..config import Settings
from ..dependencies import get_app_settings, get_http_client

router = APIRouter(prefix="/api/v1/collections", tags=["collections"])


@router.get("/travel-documents/items")
async def get_travel_documents(
    package_id: str = Query(..., alias="packageId"),
    settings: Settings = Depends(get_app_settings),
    http_client=Depends(get_http_client),
):
    client = OMSAClient(http_client, settings)
    return await client.get_travel_documents(package_id)
