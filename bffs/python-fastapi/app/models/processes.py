from datetime import datetime
from typing import List, Optional

from pydantic import BaseModel, Field


class PurchaseOffersInputs(BaseModel):
    type: str = Field(default="purchase_offers")
    timestamp: Optional[datetime] = None
    offer_ids: List[str] = Field(alias="offerIds")

    model_config = {"populate_by_name": True}


class Subscriber(BaseModel):
    success_uri: Optional[str] = Field(default=None, alias="successUri")

    model_config = {"populate_by_name": True, "extra": "allow"}


class PurchaseOffersRequest(BaseModel):
    inputs: PurchaseOffersInputs
    subscriber: Optional[Subscriber] = None

    model_config = {"populate_by_name": True, "extra": "allow"}


class PackageInputs(BaseModel):
    package_id: str = Field(alias="packageId")
    type: str = Field(default="package_input")
    timestamp: Optional[datetime] = None

    model_config = {"populate_by_name": True}


class ConfirmPackageRequest(BaseModel):
    inputs: PackageInputs

    model_config = {"populate_by_name": True, "extra": "allow"}
