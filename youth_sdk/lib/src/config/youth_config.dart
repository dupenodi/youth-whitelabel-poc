import 'package:flutter/material.dart';
import 'youth_features.dart';

/// Everything a client passes to configure their branded YOUTH experience.
///
/// The client owns this object. YOUTH owns everything behind it.
///
/// Minimal integration:
/// ```dart
/// YouthConfig(
///   clientId: 'vitacare',
///   appName: 'VitaCare',
///   primaryColor: Color(0xFF16A34A),
/// )
/// ```
///
/// Full integration with all options:
/// ```dart
/// YouthConfig(
///   clientId: 'vitacare',
///   appName: 'VitaCare',
///   tagline: 'Care that comes to you.',
///   primaryColor: Color(0xFF16A34A),
///   secondaryColor: Color(0xFFDCFCE7),
///   backgroundColor: Color(0xFFF0FDF4),
///   themeStyle: YouthThemeStyle.wellness,
///   features: YouthFeatures(
///     showVitals: true,
///     showTelemedicine: true,
///   ),
///   strings: YouthStrings(
///     ctaBook: 'Schedule Visit',
///     vitalsTitle: 'Health Summary',
///   ),
///   configApiUrl: 'https://api.vitacare.com',
/// )
/// ```
class YouthConfig {
  /// Unique identifier for this client — used to fetch remote config.
  /// Must match a record in the YOUTH config API.
  final String clientId;

  /// Display name shown in app bar and loading screen.
  final String appName;

  /// Short brand tagline shown on the home screen hero.
  final String tagline;

  /// Brand primary colour — drives buttons, app bar, accents.
  final Color primaryColor;

  /// Light tint of primary — used for card backgrounds and chips.
  final Color? secondaryColor;

  /// Darker shade of primary — used for gradients and pressed states.
  final Color? accentColor;

  /// App background colour.
  final Color? backgroundColor;

  /// Visual style preset.
  /// [YouthThemeStyle.corporate] — sharp corners, dashboard grid, solid headers.
  /// [YouthThemeStyle.wellness] — rounded corners, horizontal pills, gradient hero.
  final YouthThemeStyle themeStyle;

  /// Corner radius in dp. Overrides [themeStyle] defaults if set explicitly.
  final double? borderRadius;

  /// Which health modules to enable. Defaults to vitals + appointments.
  final YouthFeatures features;

  /// Override user-facing strings. Falls back to YOUTH defaults if not set.
  final YouthStrings strings;

  /// URL of the YOUTH config API.
  /// Defaults to YOUTH's hosted API. Override for on-premise deployments.
  final String configApiUrl;

  /// URL of a logo image shown in the app bar.
  /// Falls back to [appName] text if null or fails to load.
  final String? logoUrl;

  const YouthConfig({
    required this.clientId,
    required this.appName,
    this.tagline = '',
    required this.primaryColor,
    this.secondaryColor,
    this.accentColor,
    this.backgroundColor,
    this.themeStyle = YouthThemeStyle.corporate,
    this.borderRadius,
    this.features = const YouthFeatures(),
    this.strings = const YouthStrings(),
    this.configApiUrl = 'http://localhost:8000',
    this.logoUrl,
  });
}

/// Controls the visual layout style of the YOUTH app shell.
enum YouthThemeStyle {
  /// Clinical dashboard feel: sharp corners, 2×2 grid, solid headers.
  /// Best for: hospitals, diagnostic clinics, corporate wellness.
  corporate,

  /// Warm care feel: rounded corners, horizontal pills, gradient hero.
  /// Best for: longevity clinics, supplement brands, consumer wellness.
  wellness,
}

/// Override user-facing copy. All fields are optional — YOUTH defaults apply.
class YouthStrings {
  final String? homeGreeting;
  final String? quickAccessTitle;
  final String? vitalsTitle;
  final String? appointmentsTitle;
  final String? telemedicineTitle;
  final String? pharmacyTitle;
  final String? ctaBook;
  final String? poweredBy;

  const YouthStrings({
    this.homeGreeting,
    this.quickAccessTitle,
    this.vitalsTitle,
    this.appointmentsTitle,
    this.telemedicineTitle,
    this.pharmacyTitle,
    this.ctaBook,
    this.poweredBy,
  });
}
