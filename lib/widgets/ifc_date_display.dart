import 'package:flutter/material.dart';
import '../core/ifc_date.dart';
import '../core/theme.dart';

class IfcDateDisplay extends StatelessWidget {
  final IfcDate ifcDate;

  const IfcDateDisplay({super.key, required this.ifcDate});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSpecial = ifcDate.isYearDay || ifcDate.isLeapDay;
    final accentColor =
        isSpecial ? AppColors.specialDayGreen : AppColors.primaryPurple;

    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              accentColor.withValues(alpha: 0.08),
              accentColor.withValues(alpha: 0.02),
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '13-Month Calendar',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              ifcDate.weekdayName,
              style: theme.textTheme.titleMedium?.copyWith(
                color: accentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            if (isSpecial)
              Text(
                ifcDate.isYearDay ? 'Year Day' : 'Leap Day',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              )
            else ...[
              Text(
                '${ifcDate.monthName} ${ifcDate.day}',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${ifcDate.year}',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
            ],
            const SizedBox(height: 12),
            Text(
              isSpecial
                  ? (ifcDate.isYearDay
                      ? 'A day outside the calendar — a universal holiday'
                      : 'An extra day between June and Sol')
                  : '28 days every month',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
