from fastapi import APIRouter, Depends, Query

from ..clients.omsa import OMSAClient
from ..dependencies import get_omsa_client

router = APIRouter(prefix="/api/v1/collections", tags=["collections"])


@router.get("/travel-documents/items")
async def get_travel_documents(
    package_id: str = Query(..., alias="packageId"),
    client: OMSAClient = Depends(get_omsa_client),
):
    return await client.get_travel_documents(package_id)
