import asyncio
import json
from dataclasses import dataclass
from typing import Any, Optional

from cachetools import TTLCache


@dataclass
class CacheEntry:
    """Wrap cached data with metadata for traceability."""

    data: Any
    source: str


class OfferCache:
    """Async-safe TTL cache for offer search responses."""

    def __init__(self, ttl_seconds: int, max_size: int) -> None:
        self._cache = TTLCache(maxsize=max_size, ttl=ttl_seconds)
        self._lock = asyncio.Lock()

    async def get(self, key: str) -> Optional[CacheEntry]:
        async with self._lock:
            return self._cache.get(key)

    async def set(self, key: str, data: Any, source: str) -> None:
        async with self._lock:
            self._cache[key] = CacheEntry(data=data, source=source)

    @staticmethod
    def build_cache_key(payload: dict) -> str:
        """Return deterministic cache key for a request payload."""

        normalized = json.dumps(payload, sort_keys=True, separators=(",", ":"))
        return normalized
