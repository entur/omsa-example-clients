from fastapi import APIRouter

from . import collections, health, payments, processes

api_router = APIRouter()
api_router.include_router(health.router)
api_router.include_router(processes.router)
api_router.include_router(payments.router)
api_router.include_router(collections.router)

__all__ = ["api_router"]
