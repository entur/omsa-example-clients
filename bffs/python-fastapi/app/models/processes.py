from typing import List, Optional
from datetime import datetime

from pydantic import BaseModel, Field

from .omsa import (
    Subscriber,
    PurchaseOffersInput,
    PackageInput,
)


class PurchaseOffersInputs(PurchaseOffersInput):
    # Base class now contains offerIds: List[OfferReference]
    model_config = {"populate_by_name": True}


class PurchaseOffersRequest(BaseModel):
    inputs: PurchaseOffersInputs
    subscriber: Optional[Subscriber] = None

    model_config = {"populate_by_name": True, "extra": "ignore"}


class ConfirmPackageRequest(BaseModel):
    inputs: PackageInput

    model_config = {"populate_by_name": True, "extra": "ignore"}
