# OMSA Demo BFF

FastAPI backend-for-frontend for the OMSA demo clients. It keeps OAuth tokens, Entur headers, and the longer OMSA flows server-side so the front-end can just call REST.

## Quick start
```bash
cd bffs/python-fastapi
cp .env.example .env   # add Entur client credentials (OMSA_MODE defaults to remote)
uv sync                # installs deps into .venv via uv
uv run uvicorn app.main:app --reload
```
The API listens on `http://localhost:8000`. Remote Entur dev is the default; flip `OMSA_MODE=local` if you want to hit a stub at `http://localhost:8080`. Need a different interpreter? `uv python install 3.12` has you covered.

## Config notes
- `CLIENT_ID` / `CLIENT_SECRET`: partner credentials that stay on the server.
- `ENTUR_DISTRIBUTION_CHANNEL`, `ET_CLIENT_NAME`, `ENTUR_POS`: required Entur headers.
- `OMSA_BASE_URL` overrides everything if you want a custom endpoint. See `.env.example` for the rest.

## Project map
```
app/
  main.py         FastAPI entrypoint
  clients/        OMSA + Entur Sales HTTP clients
  routes/         Health, processes, payments
  services/cache.py  TTL cache used for offer reuse
```

## Tests
```bash
uv run pytest
```

Logs tell you almost everything. If the Flutter app can’t reach the BFF, check `/health` first, then look at OMSA responses in the console. Need schema details? The official spec lives at https://github.com/OMSA-Open-Mobility-Sales-API/OMSA.
