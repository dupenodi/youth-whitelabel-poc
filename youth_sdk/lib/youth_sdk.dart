/// YOUTH Health Tech SDK
///
/// Embed AI-powered health screening into any Flutter app.
///
/// ## Quickstart
///
/// ```dart
/// import 'package:youth_sdk/youth_sdk.dart';
///
/// void main() {
///   YouthApp.run(
///     config: YouthConfig(
///       clientId: 'vitacare',
///       appName: 'VitaCare',
///       primaryColor: Color(0xFF16A34A),
///       themeStyle: YouthThemeStyle.wellness,
///       features: YouthFeatures(
///         showVitals: true,
///         showTelemedicine: true,
///       ),
///     ),
///   );
/// }
/// ```
///
/// That's it. YOUTH handles all screens, theming, data, and future updates.
library youth_sdk;

// Public API — the only symbols a client developer needs to import
export 'src/config/youth_config.dart';
export 'src/config/youth_features.dart';
export 'src/youth_app.dart';
