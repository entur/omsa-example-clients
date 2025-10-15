# OMSA Travel Demo App

Flutter front-end plus a FastAPI backend-for-frontend (BFF) that shows how to work with Entur’s Open Mobility Sales API (OMSA).

## Why it exists
- Flutter handles the travel search, checkout flow, and ticket UI.
- The Python BFF (run with `uv`) hides OAuth, Entur headers, and OMSA orchestration from the client.
- You can point everything to Entur’s dev environment or a local stub with a single env flag.

## Quick start
```bash
flutter pub get
flutter run --dart-define=BFF_BASE_URL=http://localhost:8000/api/v1
```
The app expects a running BFF that exposes OMSA endpoints. The default base URL is `http://localhost:8000/api/v1`. See `docs/flutter-fastapi-guide.md` for a walkthrough with the FastAPI BFF.

## Repo map
```
lib/      Flutter UI, services, models
test/     Flutter widget/unit tests
```

## Useful commands
```bash
flutter test
flutter analyze
```

Questions or issues? Start with the BFF logs, then check OMSA responses. For payload formats and process docs, see the official OMSA spec: https://github.com/OMSA-Open-Mobility-Sales-API/OMSA.
