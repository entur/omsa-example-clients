# Flutter + FastAPI guide

This guide explains how to run the Flutter demo client together with the Python FastAPI backend-for-frontend (BFF).

## Prerequisites
- Flutter SDK installed (`flutter doctor` passes).
- Python 3.12+ (managed by [`uv`](https://docs.astral.sh/uv/)).
- Entur OMSA sandbox credentials (`CLIENT_ID`, `CLIENT_SECRET`, and required headers).

## 1. Start the FastAPI BFF
From the repository root:

```bash
cd bffs/python-fastapi
cp .env.example .env   # populate with Entur credentials and headers
uv sync                # installs dependencies into .venv
uv run uvicorn app.main:app --reload
```

Key notes:
- The server listens on `http://localhost:8000/api/v1` by default.
- Flip `OMSA_MODE=local` in `.env` to point at a stub backend instead of Entur's dev environment (primarily for Entur devs with a local backend running)
- `uv python install 3.12` or any version `<= 3.14 && >= 3.10` ensures the expected interpreter is available.

## 2. Run the Flutter client
In a new shell, from the repo root:

```bash
cd clients/flutter
flutter pub get
flutter run
```

Tips:
- If you have a BFF running at a different URL, run the flutter app with `--dart-define=BFF_BASE_URL=<your-bff-url-here>`.
- Update `lib/config.dart` for a checked-in default.
- Use `flutter test` and `flutter analyze` to validate changes before shipping.

## Troubleshooting
- **Client cannot reach BFF:** Hit `http://localhost:8000/health` or watch the FastAPI log output.
- **OAuth failures:** Double-check credentials in your `bffs/python-fastapi/.env`.

## Entur dev looking to add a new BFF + client combination?
- **Different pairing:** Add a new guide under `docs/` (e.g. `react-express-guide.md`) and link it from the repo README.
