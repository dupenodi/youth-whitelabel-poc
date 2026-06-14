import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'config/youth_config.dart';
import 'config/resolved_config.dart';
import 'theme/youth_theme.dart';
import 'screens/home_screen.dart';

/// The single entry point for the YOUTH SDK.
///
/// Call [YouthApp.run] from your `main()` — that's the entire integration.
class YouthApp {
  YouthApp._();

  /// Start a fully branded YOUTH health app.
  ///
  /// Pass a [YouthConfig] with your brand colours, enabled features,
  /// and custom copy. YOUTH handles all screens, theming, and data.
  ///
  /// Remote config from the YOUTH platform is merged automatically —
  /// YOUTH can push feature updates without requiring a client app release.
  static void run({required YouthConfig config}) {
    runApp(_YouthAppRoot(config: config));
  }
}

class _YouthAppRoot extends StatefulWidget {
  final YouthConfig config;
  const _YouthAppRoot({required this.config});

  @override
  State<_YouthAppRoot> createState() => _YouthAppRootState();
}

class _YouthAppRootState extends State<_YouthAppRoot> {
  ResolvedConfig? _resolved;
  String? _error;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      // Attempt to fetch remote overrides from YOUTH config API.
      // Merges with client-supplied config — remote values win.
      // Falls back gracefully to client config if API is unreachable.
      final remoteOverrides = await _fetchRemote();
      setState(() {
        _resolved = ResolvedConfig.fromYouthConfig(
          widget.config,
          remoteOverrides: remoteOverrides,
        );
      });
    } catch (_) {
      // Offline or API unreachable — use client config as-is.
      setState(() {
        _resolved = ResolvedConfig.fromYouthConfig(widget.config);
      });
    }
  }

  Future<Map<String, dynamic>?> _fetchRemote() async {
    final url =
        '${widget.config.configApiUrl}/config/${widget.config.clientId}';
    final response =
        await http.get(Uri.parse(url)).timeout(const Duration(seconds: 4));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (_resolved == null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: widget.config.primaryColor,
            ),
          ),
        ),
      );
    }

    return Provider<ResolvedConfig>.value(
      value: _resolved!,
      child: MaterialApp(
        title: _resolved!.appName,
        theme: YouthTheme.build(_resolved!),
        debugShowCheckedModeBanner: false,
        home: const YouthHomeScreen(),
      ),
    );
  }
}
