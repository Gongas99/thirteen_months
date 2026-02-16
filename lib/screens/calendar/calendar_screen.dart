import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/ifc_date.dart';
import '../../core/theme.dart';
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
          // 13 month grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 14, // 13 months + special days card
              itemBuilder: (context, index) {
                if (index < 13) {
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
                }
                return SpecialDayCard(year: year);
              },
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
    final isCurrentMonth = today != null &&
        !today!.isYearDay &&
        !today!.isLeapDay &&
        today!.month == month &&
        today!.year == year;
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isCurrentMonth
            ? (isDark ? AppColors.darkTodayHighlight : AppColors.todayHighlight)
            : null,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                IfcDate.monthNames[month],
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isCurrentMonth
                      ? (isDark ? AppColors.darkPrimaryPurpleText : AppColors.primaryPurple)
                      : null,
                ),
              ),
              const SizedBox(height: 4),
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
