import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/resolved_config.dart';

/// YOUTH appointments screen — maintained entirely by YOUTH.
class YouthAppointmentsScreen extends StatelessWidget {
  const YouthAppointmentsScreen({super.key});

  static const _appointments = [
    {'doctor': 'Dr. Priya Sharma', 'specialty': 'General Physician', 'date': 'Mon, Jun 16', 'time': '10:30 AM'},
    {'doctor': 'Dr. Rahul Mehta', 'specialty': 'Cardiologist', 'date': 'Wed, Jun 18', 'time': '2:00 PM'},
    {'doctor': 'Dr. Ananya Iyer', 'specialty': 'Dermatologist', 'date': 'Fri, Jun 20', 'time': '11:00 AM'},
  ];

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ResolvedConfig>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(config.string('appointments_title', 'Appointments')),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _appointments.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final appt = _appointments[index];
          return config.isCorporate
              ? _CorporateCard(appt: appt, config: config, theme: theme)
              : _WellnessCard(appt: appt, config: config, theme: theme);
        },
      ),
      floatingActionButton: config.isWellness
          ? FloatingActionButton.extended(
              onPressed: () {},
              label: Text(config.string('cta_book', 'Book')),
              icon: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: config.isCorporate
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: Text(config.string('cta_book', 'Book')),
                ),
              ),
            )
          : null,
    );
  }
}

class _CorporateCard extends StatelessWidget {
  final Map<String, String> appt;
  final ResolvedConfig config;
  final ThemeData theme;
  const _CorporateCard({required this.appt, required this.config, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: config.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.person, color: config.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appt['doctor']!, style: theme.textTheme.titleMedium),
                  Text(appt['specialty']!, style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _Tag(icon: Icons.calendar_today, text: appt['date']!, color: config.primary),
                      const SizedBox(width: 8),
                      _Tag(icon: Icons.access_time, text: appt['time']!, color: config.primary),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WellnessCard extends StatelessWidget {
  final Map<String, String> appt;
  final ResolvedConfig config;
  final ThemeData theme;
  const _WellnessCard({required this.appt, required this.config, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(config.borderRadius),
        border: Border.all(color: config.primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: config.secondary,
                child: Icon(Icons.person, color: config.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appt['doctor']!, style: theme.textTheme.titleMedium),
                    Text(appt['specialty']!, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: config.secondary,
              borderRadius: BorderRadius.circular(config.borderRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appt['date']!,
                    style: TextStyle(color: config.primary, fontWeight: FontWeight.w600)),
                Text(appt['time']!,
                    style: TextStyle(color: config.primary, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const _Tag({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
