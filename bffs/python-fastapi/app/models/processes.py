from typing import List, Optional
from datetime import datetime

from pydantic import BaseModel, Field

from .omsa import (
    Subscriber,
    PurchaseOffersInput,
    Selection,
    OfferReference,
    PackageInput,
    PackageReference
)


class OfferSelection(BaseModel):
    offer_id: str = Field(alias="offerId")

    model_config = {"populate_by_name": True}


class PurchaseOffersInputs(PurchaseOffersInput):
    # Backward-compatibility for older clients still sending offerIds.
    offer_ids: List[str] = Field(
        default_factory=list, alias="offerIds", exclude=True
    )
    
    def __init__(self, **data):
        # Handle the backward compatibility before passing to parent
        offer_ids = data.pop('offerIds', data.pop('offer_ids', []))
        if offer_ids and 'selections' not in data:
            data['selections'] = [{'offerId': oid} for oid in offer_ids]
        super().__init__(**data)


class PurchaseOffersRequest(BaseModel):
    inputs: PurchaseOffersInputs
    subscriber: Optional[Subscriber] = None

    model_config = {"populate_by_name": True, "extra": "ignore"}


class ConfirmPackageRequest(BaseModel):
    inputs: PackageInput

    model_config = {"populate_by_name": True, "extra": "ignore"}
