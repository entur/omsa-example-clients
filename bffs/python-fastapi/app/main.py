from __future__ import annotations

from contextlib import asynccontextmanager
from typing import AsyncIterator

import httpx
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from .config import get_settings
from .routes import api_router
from .services.cache import OfferCache


@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncIterator[None]:
    settings = get_settings()

    timeout = httpx.Timeout(15.0, connect=5.0, read=15.0, write=15.0)
    async with httpx.AsyncClient(timeout=timeout) as client:
        app.state.http_client = client  # type: ignore[attr-defined]
        app.state.offer_cache = OfferCache(
            ttl_seconds=settings.cache_ttl_seconds, max_size=settings.cache_max_size
        )  # type: ignore[attr-defined]
        yield


def create_app() -> FastAPI:
    settings = get_settings()

    app = FastAPI(
        title="OMSA Demo BFF",
        description="Backend-for-frontend for the OMSA Flutter demo application.",
        version="0.1.0",
        lifespan=lifespan,
    )

    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.cors_allow_origins,
        allow_methods=["*"],
        allow_headers=["*"],
        allow_credentials=True,
    )

    app.include_router(api_router)

    return app


app = create_app()
