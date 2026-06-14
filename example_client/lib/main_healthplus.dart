import 'package:flutter/material.dart';
import 'package:youth_sdk/youth_sdk.dart';

/// HealthPlus corporate clinic — second client, same SDK, zero shared code.
///
/// Notice: identical structure to main.dart (VitaCare).
/// Different brand → different experience.
/// Same YOUTH SDK version → same health features and data quality.
void main() {
  YouthApp.run(
    config: YouthConfig(
      clientId: 'healthplus',
      appName: 'HealthPlus',
      tagline: 'Your health, simplified.',

      primaryColor: Color(0xFF1A56DB),
      secondaryColor: Color(0xFFE8F0FE),
      accentColor: Color(0xFF0D47A1),
      backgroundColor: Color(0xFFF4F7FC),

      themeStyle: YouthThemeStyle.corporate,

      features: YouthFeatures(
        showVitals: true,
        showAppointments: true,
        showTelemedicine: false,   // ← not in HealthPlus contract
        showPharmacy: true,        // ← HealthPlus has pharmacy add-on
      ),

      strings: YouthStrings(
        homeGreeting: 'Good morning',
        quickAccessTitle: 'Clinical Tools',
        vitalsTitle: 'My Vitals',
        appointmentsTitle: 'Upcoming Appointments',
        ctaBook: 'Book Appointment',
        poweredBy: 'Powered by YOUTH Health Tech',
      ),

      configApiUrl: 'http://localhost:8000',
    ),
  );
}
