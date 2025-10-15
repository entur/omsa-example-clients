from __future__ import annotations

from datetime import datetime
from typing import List

from pydantic import BaseModel, Field


class Place(BaseModel):
    place_id: str = Field(alias="placeId")

    model_config = {"populate_by_name": True}


class SearchSpecification(BaseModel):
    from_: Place = Field(alias="from")
    to: Place
    start_time: datetime = Field(alias="startTime")
    end_time: datetime = Field(alias="endTime")

    model_config = {"populate_by_name": True}


class Traveller(BaseModel):
    type: str
    id: str
    age: int | None = None

    model_config = {"populate_by_name": True}


class SearchOfferInputs(BaseModel):
    type: str = Field(default="search_offer")
    timestamp: datetime | None = None
    specification: SearchSpecification
    travellers: List[Traveller]

    model_config = {"populate_by_name": True}


class SearchOfferRequest(BaseModel):
    inputs: SearchOfferInputs

    model_config = {"populate_by_name": True}

    def cache_payload(self) -> dict:
        """Payload used to compute cache keys."""

        payload = self.model_dump(by_alias=True, exclude_none=True, mode="json")
        # Timestamp should not influence caching, because the server sets current time
        payload["inputs"].pop("timestamp", None)
        return payload
