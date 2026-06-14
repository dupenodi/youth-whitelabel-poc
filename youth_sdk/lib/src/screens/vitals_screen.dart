import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/resolved_config.dart';

/// YOUTH vitals screen — maintained entirely by YOUTH.
/// Clients never touch this file.
/// When YOUTH adds a new biomarker, it appears here for all clients automatically.
class YouthVitalsScreen extends StatelessWidget {
  const YouthVitalsScreen({super.key});

  static const _vitals = [
    (label: 'Heart Rate', value: '72', unit: 'bpm', icon: Icons.favorite),
    (label: 'Blood Pressure', value: '120/80', unit: 'mmHg', icon: Icons.speed),
    (label: 'Blood Oxygen', value: '98', unit: '%', icon: Icons.air),
    (label: 'Temperature', value: '98.6', unit: '°F', icon: Icons.thermostat),
  ];

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ResolvedConfig>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(config.string('vitals_title', 'My Vitals')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: config.isCorporate
            ? GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.95,
                children: [
                  for (final v in _vitals)
                    _VitalCard(config: config, theme: theme, vital: v),
                ],
              )
            : ListView.separated(
                itemCount: _vitals.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) => _VitalCard(
                  config: config,
                  theme: theme,
                  vital: _vitals[i],
                  horizontal: true,
                ),
              ),
      ),
    );
  }
}

class _VitalCard extends StatelessWidget {
  final ResolvedConfig config;
  final ThemeData theme;
  final ({String label, String value, String unit, IconData icon}) vital;
  final bool horizontal;

  const _VitalCard({
    required this.config,
    required this.theme,
    required this.vital,
    this.horizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    if (horizontal) {
      return Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(config.borderRadius),
          border:
              Border.all(color: config.primary.withValues(alpha: 0.15)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: config.secondary,
                borderRadius: BorderRadius.circular(config.borderRadius),
              ),
              child: Icon(vital.icon, color: config.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(vital.label, style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(vital.value,
                          style: theme.textTheme.headlineMedium
                              ?.copyWith(fontSize: 24)),
                      if (vital.unit.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Text(vital.unit,
                            style: theme.textTheme.bodyMedium),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.trending_up, color: config.primary, size: 20),
          ],
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(vital.icon, color: config.primary, size: 20),
                const Spacer(),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF22C55E),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(vital.label,
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12)),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(vital.value,
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(fontSize: 26)),
                if (vital.unit.isNotEmpty) ...[
                  const SizedBox(width: 3),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text(vital.unit,
                        style: theme.textTheme.bodyMedium),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
