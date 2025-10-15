from fastapi import APIRouter, Depends

from ..config import Settings
from ..dependencies import get_app_settings
from ..models.health import HealthStatus

router = APIRouter(tags=["health"])


@router.get("/health", response_model=HealthStatus)
async def health(settings: Settings = Depends(get_app_settings)) -> HealthStatus:
    """Lightweight readiness probe."""

    details = {
        "omsa_mode": settings.omsa_mode,
        "omsa_base_url": settings.resolved_omsa_base_url,
    }
    missing_credentials = []
    if not settings.client_id:
        missing_credentials.append("CLIENT_ID")
    if not settings.client_secret:
        missing_credentials.append("CLIENT_SECRET")
    if missing_credentials:
        details["missing_credentials"] = ", ".join(missing_credentials)

    status_value = "ok" if not missing_credentials else "degraded"
    return HealthStatus(status=status_value, environment=settings.environment, details=details)
