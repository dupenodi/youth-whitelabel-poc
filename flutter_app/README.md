# Flutter App

## Prerequisites

- Flutter SDK ≥ 3.0
- Backend running on `http://localhost:8000` (see `../backend/`)

## Install dependencies

```bash
flutter pub get
```

## Run a flavor

```bash
# HealthPlus (blue)
flutter run \
  --dart-define=CLIENT_ID=healthplus \
  --dart-define=CONFIG_API_URL=http://localhost:8000

# VitaCare (green)
flutter run \
  --dart-define=CLIENT_ID=vitacare \
  --dart-define=CONFIG_API_URL=http://localhost:8000
```

## Build a release APK

```bash
flutter build apk \
  --dart-define=CLIENT_ID=healthplus \
  --dart-define=CONFIG_API_URL=https://your-prod-api.com
```

## Key design decisions

- `CLIENT_ID` is injected at **build time** via `--dart-define`, not at runtime. The client identity is baked into each binary — identical to how real white-label apps work.
- `config_service.dart` reads `CLIENT_ID` and fetches theme/feature config from the backend on startup.
- `AppTheme.fromConfig()` converts hex color strings to `ThemeData`, applied app-wide via `MaterialApp.theme`.
- Feature flags (e.g. `show_telemedicine`) are checked directly in widget `build()` — no extra state needed.
