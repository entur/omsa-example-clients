from datetime import datetime
from typing import List, Optional

from pydantic import BaseModel, Field, model_validator


class OfferSelection(BaseModel):
    offer_id: str = Field(alias="offerId")

    model_config = {"populate_by_name": True}


class PurchaseOffersInputs(BaseModel):
    type: str = Field(default="purchase_offers")
    timestamp: Optional[datetime] = None
    selections: List[OfferSelection] = Field(default_factory=list)
    # Backward-compatibility for older clients still sending offerIds.
    offer_ids: List[str] = Field(
        default_factory=list, alias="offerIds", exclude=True
    )

    model_config = {"populate_by_name": True}

    @model_validator(mode="after")
    def _normalize_selections(self) -> "PurchaseOffersInputs":
        if not self.selections and self.offer_ids:
            self.selections = [
                OfferSelection(offer_id=offer_id) for offer_id in self.offer_ids
            ]
        if not self.selections:
            raise ValueError("inputs.selections must contain at least one item")
        return self


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
