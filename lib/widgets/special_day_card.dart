import 'package:flutter/material.dart';
import 'package:thirteen_months/l10n/app_localizations.dart';
import '../core/ifc_date.dart';
import '../core/theme.dart';

class SpecialDayCard extends StatelessWidget {
  final int year;

  const SpecialDayCard({super.key, required this.year});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final isLeap = IfcDate.isLeapYear(year);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.specialDays,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _SpecialDayRow(
              icon: Icons.celebration,
              title: l10n.yearDay,
              subtitle: l10n.yearDayDesc,
              color: AppColors.specialDayGreen,
            ),
            if (isLeap) ...[
              const SizedBox(height: 8),
              _SpecialDayRow(
                icon: Icons.add_circle_outline,
                title: l10n.leapDay,
                subtitle: l10n.leapDayDesc,
                color: AppColors.specialDayGreen,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SpecialDayRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _SpecialDayRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
