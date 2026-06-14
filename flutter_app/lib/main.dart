import 'package:flutter/material.dart';
import 'package:youth_sdk/youth_sdk.dart';

/// Runnable demo of the YOUTH SDK.
///
/// Switch CLIENT_ID at build time to see a different brand:
///   flutter run --dart-define=CLIENT_ID=healthplus
///   flutter run --dart-define=CLIENT_ID=vitacare
///   flutter run --dart-define=CLIENT_ID=mediview
void main() {
  const clientId = String.fromEnvironment('CLIENT_ID', defaultValue: 'healthplus');
  YouthApp.run(config: _configs[clientId] ?? _configs['healthplus']!);
}

const _apiUrl = String.fromEnvironment(
  'CONFIG_API_URL',
  defaultValue: 'http://localhost:8000',
);

final _configs = <String, YouthConfig>{
  'healthplus': const YouthConfig(
    clientId: 'healthplus',
    appName: 'HealthPlus',
    tagline: 'Your health, simplified.',
    primaryColor: Color(0xFF1A56DB),
    secondaryColor: Color(0xFFE8F0FE),
    accentColor: Color(0xFF0D47A1),
    backgroundColor: Color(0xFFF4F7FC),
    themeStyle: YouthThemeStyle.corporate,
    features: YouthFeatures(showVitals: true, showAppointments: true, showPharmacy: true),
    strings: YouthStrings(
      homeGreeting: 'Good morning',
      quickAccessTitle: 'Clinical Tools',
      vitalsTitle: 'My Vitals',
      appointmentsTitle: 'Upcoming Appointments',
      ctaBook: 'Book Appointment',
      poweredBy: 'Powered by YOUTH Health Tech',
    ),
    configApiUrl: _apiUrl,
  ),
  'vitacare': const YouthConfig(
    clientId: 'vitacare',
    appName: 'VitaCare',
    tagline: 'Care that comes to you.',
    primaryColor: Color(0xFF16A34A),
    secondaryColor: Color(0xFFDCFCE7),
    accentColor: Color(0xFF14532D),
    backgroundColor: Color(0xFFF0FDF4),
    themeStyle: YouthThemeStyle.wellness,
    features: YouthFeatures(showVitals: true, showAppointments: true, showTelemedicine: true),
    strings: YouthStrings(
      homeGreeting: 'Welcome back',
      quickAccessTitle: 'Your Care Hub',
      vitalsTitle: 'Health Summary',
      appointmentsTitle: 'Your Schedule',
      telemedicineTitle: 'Talk to a Doctor',
      ctaBook: 'Schedule Visit',
      poweredBy: 'Care by YOUTH',
    ),
    configApiUrl: _apiUrl,
  ),
  'mediview': const YouthConfig(
    clientId: 'mediview',
    appName: 'MediView',
    tagline: 'See your health clearly.',
    primaryColor: Color(0xFF7C3AED),
    secondaryColor: Color(0xFFEDE9FE),
    accentColor: Color(0xFF5B21B6),
    backgroundColor: Color(0xFFFAF5FF),
    themeStyle: YouthThemeStyle.corporate,
    features: YouthFeatures(showVitals: true, showAppointments: true, showTelemedicine: true),
    strings: YouthStrings(
      homeGreeting: 'Hello',
      quickAccessTitle: 'Patient Portal',
      vitalsTitle: 'Lab Results',
      appointmentsTitle: 'Consultations',
      telemedicineTitle: 'Virtual Visit',
      ctaBook: 'Request Consultation',
      poweredBy: 'MediView × YOUTH',
    ),
    configApiUrl: _apiUrl,
  ),
};
