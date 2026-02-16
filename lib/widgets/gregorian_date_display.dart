import 'package:flutter/material.dart';
import 'package:thirteen_months/l10n/app_localizations.dart';
import '../l10n/ifc_localizations.dart';

class GregorianDateDisplay extends StatelessWidget {
  final DateTime date;

  const GregorianDateDisplay({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final weekday = IfcLocalizations.gregWeekday(l10n, date.weekday);
    final month = IfcLocalizations.gregMonth(l10n, date.month);

    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          children: [
            Text(
              l10n.yourCalendar,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.textTheme.bodySmall?.color,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              weekday,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$month ${date.day}',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${date.year}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
