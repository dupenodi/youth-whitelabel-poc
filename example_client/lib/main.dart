import 'package:flutter/material.dart';
import 'package:youth_sdk/youth_sdk.dart';

/// VitaCare longevity clinic — full branded health app.
///
/// This is the ENTIRE codebase for a client integration.
/// YOUTH owns and maintains all screens, health features, and data.
/// VitaCare owns their brand config below.
///
/// When YOUTH ships SDK v1.1 (new biomarkers, new features):
///   1. VitaCare updates pubspec.yaml: youth_sdk: ^1.1.0
///   2. Run `flutter pub upgrade`
///   3. Done. No code changes required.
void main() {
  YouthApp.run(
    config: YouthConfig(
      clientId: 'vitacare',
      appName: 'VitaCare',
      tagline: 'Care that comes to you.',

      // Brand colours — the only design decision VitaCare makes
      primaryColor: Color(0xFF16A34A),
      secondaryColor: Color(0xFFDCFCE7),
      accentColor: Color(0xFF14532D),
      backgroundColor: Color(0xFFF0FDF4),

      // Layout preset
      themeStyle: YouthThemeStyle.wellness,

      // Which YOUTH modules to enable
      // (requires corresponding add-on contracts)
      features: YouthFeatures(
        showVitals: true,
        showAppointments: true,
        showTelemedicine: true,    // ← VitaCare has telemedicine add-on
        showPharmacy: false,       // ← not in VitaCare's contract
      ),

      // Custom copy — falls back to YOUTH defaults if not set
      strings: YouthStrings(
        homeGreeting: 'Welcome back',
        quickAccessTitle: 'Your Care Hub',
        vitalsTitle: 'Health Summary',
        appointmentsTitle: 'Your Schedule',
        telemedicineTitle: 'Talk to a Doctor',
        ctaBook: 'Schedule Visit',
        poweredBy: 'Care by YOUTH',
      ),

      // Point at YOUTH's hosted config API (or client's on-premise deployment)
      configApiUrl: 'http://localhost:8000',
    ),
  );
}
