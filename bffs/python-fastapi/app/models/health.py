from datetime import datetime, timezone
from typing import Literal

from pydantic import BaseModel, Field


class HealthStatus(BaseModel):
    status: Literal["ok", "degraded", "error"] = Field(default="ok")
    environment: str
    timestamp: datetime = Field(
        default_factory=lambda: datetime.now(tz=timezone.utc)
    )
    details: dict[str, str] = Field(default_factory=dict)
