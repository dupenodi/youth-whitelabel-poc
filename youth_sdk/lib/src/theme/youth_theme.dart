import 'package:flutter/material.dart';
import '../config/resolved_config.dart';
import '../config/youth_config.dart';

class YouthTheme {
  static ThemeData build(ResolvedConfig config) {
    final radius = BorderRadius.circular(config.borderRadius);

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: config.primary,
        secondary: config.secondary,
        tertiary: config.accent,
        surface: config.background,
        onPrimary: Colors.white,
        onSurface: config.textPrimary,
      ),
      scaffoldBackgroundColor: config.background,
      appBarTheme: AppBarTheme(
        backgroundColor:
            config.isCorporate ? config.primary : Colors.transparent,
        foregroundColor:
            config.isCorporate ? Colors.white : config.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          color: config.isCorporate ? Colors.white : config.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: config.primary,
          foregroundColor: Colors.white,
          elevation: config.isWellness ? 2 : 0,
          shape: RoundedRectangleBorder(borderRadius: radius),
          padding: EdgeInsets.symmetric(
            horizontal: config.isWellness ? 28 : 24,
            vertical: config.isWellness ? 16 : 14,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: config.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: radius),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: config.themeStyle == YouthThemeStyle.corporate ? 3 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: config.themeStyle == YouthThemeStyle.wellness
              ? BorderSide(
                  color: config.primary.withValues(alpha: 0.15))
              : BorderSide.none,
        ),
        margin: EdgeInsets.zero,
      ),
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          color: config.textPrimary,
          fontWeight: config.isCorporate ? FontWeight.w700 : FontWeight.w600,
          fontSize: config.isCorporate ? 22 : 26,
        ),
        titleMedium: TextStyle(
          color: config.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        bodyLarge: TextStyle(color: config.textPrimary, fontSize: 15),
        bodyMedium: TextStyle(color: config.textSecondary, fontSize: 14),
        labelLarge: TextStyle(
          color: config.primary,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}
