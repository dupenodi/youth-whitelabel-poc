# YOUTH White-Label SDK — POC

A proof of concept showing how YOUTH Health Tech can ship a Flutter SDK that lets any clinic or supplement brand embed their health screening platform under their own brand — without YOUTH maintaining separate codebases per client.

## The Problem

YOUTH builds a health screening platform and white-labels it for longevity clinics and supplement brands. Each client wants their own branded app. Right now that means:

- Engineering time spent per client setup
- Every platform improvement (new biomarker, bug fix) requires touching all client codebases separately
- Doesn't scale past 20–30 clients without proportionally growing the team

## The Solution

A Flutter SDK (`youth_sdk`) where:

- A new client integration is ~50 lines of config — no YOUTH engineer needed after initial setup
- YOUTH ships improvements once; all clients get them by bumping a version number
- Feature flags are per-client and per-contract (`showTelemedicine`, `showPharmacy`, etc.)
- Remote config from the YOUTH API merges at launch — config changes don't require an App Store submission

## Repo Structure

```
youth_sdk/          ← YOUTH owns this. Clients never touch it.
├── lib/
│   ├── youth_sdk.dart          public API (3 exports)
│   └── src/
│       ├── config/             YouthConfig, YouthFeatures, ResolvedConfig
│       ├── theme/              theme engine driven by config
│       ├── screens/            home, vitals, appointments
│       └── youth_app.dart      single entry point: YouthApp.run()

example_client/     ← what a client's entire codebase looks like
└── lib/main.dart   (~50 lines — brand config only)

flutter_app/        ← runnable demo (3 brands via --dart-define)
└── lib/main.dart

backend/            ← FastAPI config API (source of truth per client)
└── configs/
    ├── healthplus.json
    ├── vitacare.json
    └── mediview.json
```

## Client Integration

This is the entire codebase for a client app:

```dart
import 'package:youth_sdk/youth_sdk.dart';

void main() {
  YouthApp.run(
    config: YouthConfig(
      clientId: 'vitacare',
      appName: 'VitaCare',
      tagline: 'Care that comes to you.',
      primaryColor: Color(0xFF16A34A),
      themeStyle: YouthThemeStyle.wellness,
      features: YouthFeatures(
        showVitals: true,
        showTelemedicine: true,  // add-on contract
        showPharmacy: false,
      ),
      strings: YouthStrings(
        ctaBook: 'Schedule Visit',
        vitalsTitle: 'Health Summary',
      ),
    ),
  );
}
```

YOUTH owns everything behind `YouthApp.run()`. When YOUTH ships SDK v1.1, clients update one line in `pubspec.yaml`. No code changes required.

## Running Locally

**1. Start the config API**

```bash
cd backend
pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```

**2. Run a branded app on iOS Simulator**

```bash
# boot simulator
xcrun simctl boot "iPhone 17"

cd flutter_app
flutter pub get

# HealthPlus — blue, corporate dashboard
flutter run -d "iPhone 17" \
  --dart-define=CLIENT_ID=healthplus \
  --dart-define=CONFIG_API_URL=http://localhost:8000

# VitaCare — green, wellness layout
flutter run -d "iPhone 17" \
  --dart-define=CLIENT_ID=vitacare \
  --dart-define=CONFIG_API_URL=http://localhost:8000

# MediView — purple (third client)
flutter run -d "iPhone 17" \
  --dart-define=CLIENT_ID=mediview \
  --dart-define=CONFIG_API_URL=http://localhost:8000
```

## Three Clients, One Codebase

| | HealthPlus | VitaCare | MediView |
|---|---|---|---|
| Color | Blue `#1A56DB` | Green `#16A34A` | Purple `#7C3AED` |
| Layout | Corporate grid | Wellness pills | Corporate grid |
| Telemedicine | ❌ | ✅ | ✅ |
| Pharmacy | ✅ | ❌ | ❌ |

## Adding a New Client

1. Add `backend/configs/newclient.json`
2. Pass their config to `YouthApp.run()` (or use `CLIENT_ID=newclient` in the demo)
3. Build and submit under their bundle ID

No changes to `youth_sdk`. No changes to any other client.

---

*Stack: Flutter + FastAPI. Built to demonstrate white-label SDK architecture for YOUTH Health Tech.*
