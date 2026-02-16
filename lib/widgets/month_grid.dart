import 'package:flutter/material.dart';
import '../core/ifc_date.dart';
import '../core/theme.dart';

class MonthGrid extends StatelessWidget {
  final int month;
  final int year;
  final IfcDate? today;
  final bool compact;
  final void Function(int day)? onDayTap;

  const MonthGrid({
    super.key,
    required this.month,
    required this.year,
    this.today,
    this.compact = false,
    this.onDayTap,
  });

  bool _isToday(int day) {
    if (today == null || today!.isYearDay || today!.isLeapDay) return false;
    return today!.month == month && today!.day == day && today!.year == year;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerStyle = (compact
            ? theme.textTheme.labelSmall
            : theme.textTheme.labelMedium)
        ?.copyWith(
      fontWeight: FontWeight.w600,
      color: theme.textTheme.bodySmall?.color,
    );
    final dayStyle = compact ? theme.textTheme.bodySmall : theme.textTheme.bodyMedium;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header row: S M T W T F S
        Row(
          children: IfcDate.weekdayAbbreviations.map((abbr) {
            return Expanded(
              child: Center(
                child: Text(
                  compact ? abbr[0] : abbr,
                  style: headerStyle,
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: compact ? 2 : 8),
        // 4 weeks x 7 days
        for (int week = 0; week < 4; week++)
          Row(
            children: List.generate(7, (weekday) {
              final day = week * 7 + weekday + 1;
              final isHighlighted = _isToday(day);

              return Expanded(
                child: GestureDetector(
                  onTap: onDayTap != null ? () => onDayTap!(day) : null,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: compact ? 2 : 6,
                    ),
                    decoration: isHighlighted
                        ? BoxDecoration(
                            color: AppColors.primaryPurple,
                            borderRadius: BorderRadius.circular(compact ? 4 : 8),
                          )
                        : null,
                    child: Center(
                      child: Text(
                        '$day',
                        style: dayStyle?.copyWith(
                          color: isHighlighted
                              ? Colors.white
                              : (weekday == 6
                                  ? theme.textTheme.bodySmall?.color
                                  : null),
                          fontWeight:
                              isHighlighted ? FontWeight.bold : null,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
      ],
    );
  }
}
