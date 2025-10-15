# OMSA Example Clients

This repository hosts a complete demo of Entur's implementation of the [Open Mobility Sales API (OMSA)](https://github.com/OMSA-Open-Mobility-Sales-API/OMSA). Each client lives under `clients/`, each backend-for-frontend (BFF) under `bffs/`. Shared documentation and guides for BFF + client combinations live under `docs/`.

Note from October 15 2025: We currently only support a Flutter client + Python FastAPI BFF. This repo may contain other clients and BFFs in the future.

## Repository layout
```
clients/
  flutter/             Cross-platform mobile client
bffs/
  python-fastapi/      Reference FastAPI BFF
docs/                  Shared documentation and BFF + client integration guides
```

## Getting started
- Each project documents its own setup:
  - [clients/flutter/README.md](clients/flutter/README.md) covers the Flutter demo app.
  - [bffs/python-fastapi/README.md](bffs/python-fastapi/README.md) covers the FastAPI BFF.
- Integration guides live in `docs/`. Start with [docs/flutter-fastapi-guide.md](docs/flutter-fastapi-guide.md) to run the Flutter client against the FastAPI BFF.

## Documentation
- Add new client/BFF pairings under `docs/` as `client-bff-guide.md` to keep combinations discoverable (e.g. `react-express-guide.md`).
- Official OMSA specification: <https://github.com/OMSA-Open-Mobility-Sales-API/OMSA>
