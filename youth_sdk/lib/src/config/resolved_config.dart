import 'package:flutter/material.dart';
import 'youth_config.dart';
import 'youth_features.dart';

/// Internal representation of config after merging client-supplied [YouthConfig]
/// with any remote overrides fetched from the YOUTH config API.
///
/// Clients never interact with this directly — it's YOUTH's internal contract.
class ResolvedConfig {
  final String clientId;
  final String appName;
  final String tagline;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color textPrimary;
  final Color textSecondary;
  final String? logoUrl;
  final YouthThemeStyle themeStyle;
  final double borderRadius;
  final YouthFeatures features;
  final Map<String, String> strings;

  const ResolvedConfig({
    required this.clientId,
    required this.appName,
    required this.tagline,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.textPrimary,
    required this.textSecondary,
    this.logoUrl,
    required this.themeStyle,
    required this.borderRadius,
    required this.features,
    required this.strings,
  });

  bool get isCorporate => themeStyle == YouthThemeStyle.corporate;
  bool get isWellness => themeStyle == YouthThemeStyle.wellness;
  bool feature(String key) => features.toMap()[key] == true;
  String string(String key, [String fallback = '']) => strings[key] ?? fallback;

  /// Build from a [YouthConfig] supplied by the client, optionally merged
  /// with JSON from the remote config API (remote values take precedence
  /// so YOUTH can push changes without a client app update).
  factory ResolvedConfig.fromYouthConfig(
    YouthConfig config, {
    Map<String, dynamic>? remoteOverrides,
  }) {
    final r = remoteOverrides ?? {};

    Color parseHex(String hex) {
      final buffer = StringBuffer();
      if (hex.length == 7) buffer.write('ff');
      buffer.write(hex.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    }

    final primary = r['primary_color'] != null
        ? parseHex(r['primary_color'])
        : config.primaryColor;

    final secondary = r['secondary_color'] != null
        ? parseHex(r['secondary_color'])
        : config.secondaryColor ?? _lighten(primary);

    final accent = r['accent_color'] != null
        ? parseHex(r['accent_color'])
        : config.accentColor ?? _darken(primary);

    final background = r['background_color'] != null
        ? parseHex(r['background_color'])
        : config.backgroundColor ?? const Color(0xFFF8FAFF);

    final remoteFeatures = r['features'] as Map<String, dynamic>? ?? {};
    final resolvedFeatures = YouthFeatures(
      showVitals: remoteFeatures['show_vitals'] as bool? ?? config.features.showVitals,
      showAppointments: remoteFeatures['show_appointments'] as bool? ?? config.features.showAppointments,
      showTelemedicine: remoteFeatures['show_telemedicine'] as bool? ?? config.features.showTelemedicine,
      showPharmacy: remoteFeatures['show_pharmacy'] as bool? ?? config.features.showPharmacy,
    );

    final remoteStrings = Map<String, String>.from(r['strings'] ?? {});
    final s = config.strings;
    final resolvedStrings = {
      'home_greeting': remoteStrings['home_greeting'] ?? s.homeGreeting ?? 'Hello',
      'quick_access_title': remoteStrings['quick_access_title'] ?? s.quickAccessTitle ?? 'Health Tools',
      'vitals_title': remoteStrings['vitals_title'] ?? s.vitalsTitle ?? 'My Vitals',
      'appointments_title': remoteStrings['appointments_title'] ?? s.appointmentsTitle ?? 'Appointments',
      'telemedicine_title': remoteStrings['telemedicine_title'] ?? s.telemedicineTitle ?? 'Video Consult',
      'pharmacy_title': remoteStrings['pharmacy_title'] ?? s.pharmacyTitle ?? 'Pharmacy',
      'cta_book': remoteStrings['cta_book'] ?? s.ctaBook ?? 'Book Now',
      'powered_by': remoteStrings['powered_by'] ?? s.poweredBy ?? 'Powered by YOUTH',
    };

    final themeStyle = _parseThemeStyle(r['theme_style']) ?? config.themeStyle;
    final borderRadius = (r['border_radius'] as num?)?.toDouble() ??
        config.borderRadius ??
        (themeStyle == YouthThemeStyle.wellness ? 24.0 : 8.0);

    return ResolvedConfig(
      clientId: config.clientId,
      appName: r['app_name'] as String? ?? config.appName,
      tagline: r['tagline'] as String? ?? config.tagline,
      primary: primary,
      secondary: secondary,
      accent: accent,
      background: background,
      textPrimary: const Color(0xFF1A1A2E),
      textSecondary: const Color(0xFF5A6A8A),
      logoUrl: r['logo_url'] as String? ?? config.logoUrl,
      themeStyle: themeStyle,
      borderRadius: borderRadius,
      features: resolvedFeatures,
      strings: resolvedStrings,
    );
  }

  static YouthThemeStyle? _parseThemeStyle(dynamic value) {
    if (value == 'wellness') return YouthThemeStyle.wellness;
    if (value == 'corporate') return YouthThemeStyle.corporate;
    return null;
  }

  static Color _lighten(Color c) =>
      Color.lerp(c, Colors.white, 0.85) ?? c;

  static Color _darken(Color c) =>
      Color.lerp(c, Colors.black, 0.25) ?? c;
}
