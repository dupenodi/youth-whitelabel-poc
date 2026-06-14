import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../config/resolved_config.dart';
import '../config/youth_config.dart';
import 'vitals_screen.dart';
import 'appointments_screen.dart';

/// YOUTH home screen — maintained entirely by YOUTH.
/// Layout switches automatically based on [ResolvedConfig.themeStyle].
class YouthHomeScreen extends StatelessWidget {
  const YouthHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ResolvedConfig>(context);
    return config.isCorporate
        ? _CorporateHome(config: config)
        : _WellnessHome(config: config);
  }
}

// ─── Corporate layout ──────────────────────────────────────────────────────

class _CorporateHome extends StatelessWidget {
  final ResolvedConfig config;
  const _CorporateHome({required this.config});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: _AppBarTitle(config: config),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Solid banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: config.primary,
                borderRadius: BorderRadius.circular(config.borderRadius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${config.string('home_greeting')}, Sharath',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    config.tagline,
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                _MiniStat(config: config, label: 'Heart Rate', value: '72 bpm'),
                const SizedBox(width: 10),
                _MiniStat(config: config, label: 'Steps Today', value: '4.2k'),
                const SizedBox(width: 10),
                _MiniStat(config: config, label: 'Sleep', value: '7.1 hrs'),
              ],
            ),

            const SizedBox(height: 28),
            Text(config.string('quick_access_title', 'Clinical Tools'),
                style: theme.textTheme.headlineMedium?.copyWith(fontSize: 18)),
            const SizedBox(height: 14),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: _buildTiles(context),
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: Text(config.string('cta_book', 'Book')),
              ),
            ),

            const SizedBox(height: 16),
            Center(
              child: Text(config.string('powered_by', 'Powered by YOUTH'),
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 11)),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTiles(BuildContext context) {
    return [
      if (config.feature('show_vitals'))
        _Tile(
          config: config,
          icon: Icons.monitor_heart_outlined,
          label: config.string('vitals_title', 'Vitals'),
          onTap: () => _push(context, const YouthVitalsScreen()),
        ),
      if (config.feature('show_appointments'))
        _Tile(
          config: config,
          icon: Icons.event_note_outlined,
          label: config.string('appointments_title', 'Appointments'),
          onTap: () => _push(context, const YouthAppointmentsScreen()),
        ),
      if (config.feature('show_pharmacy'))
        _Tile(
          config: config,
          icon: Icons.local_pharmacy_outlined,
          label: config.string('pharmacy_title', 'Pharmacy'),
          onTap: () {},
        ),
      if (config.feature('show_telemedicine'))
        _Tile(
          config: config,
          icon: Icons.videocam_outlined,
          label: config.string('telemedicine_title', 'Telemedicine'),
          onTap: () {},
        ),
    ];
  }
}

// ─── Wellness layout ───────────────────────────────────────────────────────

class _WellnessHome extends StatelessWidget {
  final ResolvedConfig config;
  const _WellnessHome({required this.config});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: config.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gradient hero
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [config.primary, config.accent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(config.borderRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${config.string('home_greeting')}, Sharath 👋',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.5),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      config.tagline,
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle,
                              color: Colors.white, size: 16),
                          SizedBox(width: 6),
                          Text('All vitals normal',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  config.string('quick_access_title', 'Your Care Hub'),
                  style: theme.textTheme.headlineMedium?.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(height: 14),

              SizedBox(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    if (config.feature('show_vitals'))
                      _PillTile(
                        config: config,
                        icon: Icons.favorite_outline,
                        label: 'Vitals',
                        onTap: () => _push(context, const YouthVitalsScreen()),
                      ),
                    if (config.feature('show_appointments'))
                      _PillTile(
                        config: config,
                        icon: Icons.calendar_today_outlined,
                        label: 'Schedule',
                        onTap: () =>
                            _push(context, const YouthAppointmentsScreen()),
                      ),
                    if (config.feature('show_pharmacy'))
                      _PillTile(
                        config: config,
                        icon: Icons.medication_outlined,
                        label: 'Pharmacy',
                        onTap: () {},
                      ),
                  ],
                ),
              ),

              // Telemedicine hero card — only when feature enabled
              if (config.feature('show_telemedicine'))
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: config.secondary,
                        borderRadius:
                            BorderRadius.circular(config.borderRadius),
                        border: Border.all(
                            color: config.primary.withValues(alpha: 0.25)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: config.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.video_call,
                                color: Colors.white, size: 28),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  config.string('telemedicine_title',
                                      'Talk to a Doctor'),
                                  style: theme.textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text('Available now · avg wait 3 min',
                                    style: theme.textTheme.bodyMedium),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 16, color: config.primary),
                        ],
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle_outline),
                    label: Text(config.string('cta_book', 'Schedule')),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(config.string('powered_by', 'Powered by YOUTH'),
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 11)),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Shared sub-widgets ────────────────────────────────────────────────────

class _AppBarTitle extends StatelessWidget {
  final ResolvedConfig config;
  const _AppBarTitle({required this.config});

  @override
  Widget build(BuildContext context) {
    if (config.logoUrl != null) {
      return CachedNetworkImage(
        imageUrl: config.logoUrl!,
        height: 28,
        errorWidget: (_, __, ___) => Text(config.appName),
      );
    }
    return Text(config.appName);
  }
}

class _MiniStat extends StatelessWidget {
  final ResolvedConfig config;
  final String label;
  final String value;
  const _MiniStat(
      {required this.config, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(config.borderRadius),
          border: Border.all(color: config.secondary),
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    color: config.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14)),
            const SizedBox(height: 2),
            Text(label,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 10),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final ResolvedConfig config;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _Tile(
      {required this.config,
      required this.icon,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(config.borderRadius),
          border: Border.all(color: config.secondary),
          boxShadow: [
            BoxShadow(
                color: config.primary.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: config.secondary,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: config.primary, size: 22),
            ),
            const Spacer(),
            Text(label, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}

class _PillTile extends StatelessWidget {
  final ResolvedConfig config;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _PillTile(
      {required this.config,
      required this.icon,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 110,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(config.borderRadius),
            border:
                Border.all(color: config.primary.withValues(alpha: 0.2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: config.secondary,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: config.primary, size: 26),
              ),
              const SizedBox(height: 10),
              Text(label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}

void _push(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}
