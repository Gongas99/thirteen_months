import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/ifc_date.dart';
import '../../core/theme.dart';
import '../../state/app_state.dart';
import '../../widgets/month_grid.dart';

class MonthDetailScreen extends StatefulWidget {
  final int initialMonth;

  const MonthDetailScreen({super.key, required this.initialMonth});

  @override
  State<MonthDetailScreen> createState() => _MonthDetailScreenState();
}

class _MonthDetailScreenState extends State<MonthDetailScreen> {
  late PageController _pageController;
  late int _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.initialMonth;
    _pageController = PageController(initialPage: widget.initialMonth - 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final year = appState.calendarYear;
    final today = appState.todayIfc;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${IfcDate.monthNames[_currentMonth]} $year'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: 13,
        onPageChanged: (index) {
          setState(() => _currentMonth = index + 1);
        },
        itemBuilder: (context, index) {
          final month = index + 1;
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  IfcDate.monthNames[month],
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Month $month of 13',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryPurple,
                  ),
                ),
                const SizedBox(height: 24),
                MonthGrid(
                  month: month,
                  year: year,
                  today: today,
                  onDayTap: (day) {
                    final ifc = IfcDate(month: month, day: day, year: year);
                    final greg = ifc.toGregorian();
                    _showDayInfo(context, ifc, greg);
                  },
                ),
                const SizedBox(height: 24),
                _MonthInfoCard(month: month, year: year),
                const Spacer(),
                Center(
                  child: Text(
                    'Swipe to navigate between months',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color
                          ?.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDayInfo(BuildContext context, IfcDate ifc, DateTime greg) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                ifc.formatted,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${ifc.year}',
                style: theme.textTheme.titleMedium,
              ),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Gregorian:', style: theme.textTheme.bodyMedium),
                  Text(
                    '${greg.year}-${greg.month.toString().padLeft(2, '0')}-${greg.day.toString().padLeft(2, '0')}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Week of month:', style: theme.textTheme.bodyMedium),
                  Text(
                    '${ifc.weekOfMonth} of 4',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

class _MonthInfoCard extends StatelessWidget {
  final int month;
  final int year;

  const _MonthInfoCard({required this.month, required this.year});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final firstDay = IfcDate(month: month, day: 1, year: year);
    final lastDay = IfcDate(month: month, day: 28, year: year);
    final gregFirst = firstDay.toGregorian();
    final gregLast = lastDay.toGregorian();

    String formatGreg(DateTime d) =>
        '${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text('Gregorian range',
                    style: theme.textTheme.labelSmall),
                const SizedBox(height: 4),
                Text(
                  '${formatGreg(gregFirst)} – ${formatGreg(gregLast)}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text('Days', style: theme.textTheme.labelSmall),
                const SizedBox(height: 4),
                Text(
                  '28',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text('Weeks', style: theme.textTheme.labelSmall),
                const SizedBox(height: 4),
                Text(
                  '4',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
