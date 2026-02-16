import 'package:flutter/material.dart';
import 'package:thirteen_months/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../core/ifc_date.dart';
import '../../core/theme.dart';
import '../../l10n/ifc_localizations.dart';
import '../../state/app_state.dart';
import '../../widgets/month_grid.dart';
import '../../widgets/special_day_card.dart';
import 'month_detail_screen.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final year = appState.calendarYear;
    final today = appState.todayIfc;
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final isLeap = IfcDate.isLeapYear(year);

    return SafeArea(
      child: Column(
        children: [
          // Year selector
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: appState.previousYear,
                  icon: const Icon(Icons.chevron_left),
                ),
                Text(
                  '$year',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: appState.nextYear,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          // Fun fact
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline,
                    color: AppColors.primaryPurple, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.calendarFunFact,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Scrollable content: 13 month grid + special days + day count
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
              children: [
                // 13-month grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: 13,
                  itemBuilder: (context, index) {
                    final month = index + 1;
                    return _MonthCard(
                      month: month,
                      year: year,
                      today: today,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider.value(
                            value: appState,
                            child: MonthDetailScreen(initialMonth: month),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                // Special days card — full width
                SpecialDayCard(year: year),
                const SizedBox(height: 8),
                // Day count summary — full width
                _DayCountCard(year: year, isLeap: isLeap),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthCard extends StatelessWidget {
  final int month;
  final int year;
  final IfcDate? today;
  final VoidCallback? onTap;

  const _MonthCard({
    required this.month,
    required this.year,
    this.today,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final isCurrentMonth = today != null &&
        !today!.isYearDay &&
        !today!.isLeapDay &&
        today!.month == month &&
        today!.year == year;
    final isDark = theme.brightness == Brightness.dark;
    final accentColor =
        isDark ? AppColors.darkPrimaryPurpleText : AppColors.primaryPurple;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isCurrentMonth
            ? (isDark ? AppColors.darkTodayHighlight : AppColors.todayHighlight)
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: Text(
                      IfcLocalizations.monthName(l10n, month),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isCurrentMonth ? accentColor : null,
                      ),
                    ),
                  ),
                  Text(
                    '$month',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isCurrentMonth
                          ? accentColor.withValues(alpha: 0.7)
                          : theme.colorScheme.onSurfaceVariant
                              .withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Expanded(
                child: MonthGrid(
                  month: month,
                  year: year,
                  today: today,
                  compact: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DayCountCard extends StatelessWidget {
  final int year;
  final bool isLeap;

  const _DayCountCard({required this.year, required this.isLeap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final regularDays = 13 * 28;
    final totalDays = regularDays + 1 + (isLeap ? 1 : 0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '13 × 28 = $regularDays',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            Text(
              l10n.plusYearDay,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (isLeap)
              Text(
                ' ${l10n.plusLeapDay}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            Text(
              ' = ',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              l10n.daysLabel(totalDays),
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
