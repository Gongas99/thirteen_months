import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/ifc_date.dart';
import '../../core/ifc_constants.dart';
import '../../core/theme.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  bool _gregorianToIfc = true;

  // Gregorian → IFC
  DateTime _selectedGregorianDate = DateTime.now();
  IfcDate? _convertedIfcDate;

  // IFC → Gregorian
  int _selectedIfcYear = DateTime.now().year;
  int _selectedIfcMonth = 1;
  int _selectedIfcDay = 1;
  String _selectedSpecial = 'none'; // 'none', 'yearDay', 'leapDay'
  DateTime? _convertedGregorianDate;

  final _random = Random();
  late String _funFact;

  @override
  void initState() {
    super.initState();
    _funFact = IfcConstants.converterFunFacts[
        _random.nextInt(IfcConstants.converterFunFacts.length)];
    _convertGregorianToIfc();
  }

  void _convertGregorianToIfc() {
    setState(() {
      _convertedIfcDate = IfcDate.fromGregorian(_selectedGregorianDate);
    });
  }

  void _convertIfcToGregorian() {
    setState(() {
      try {
        IfcDate ifc;
        if (_selectedSpecial == 'yearDay') {
          ifc = IfcDate(
            month: 0,
            day: 0,
            year: _selectedIfcYear,
            isYearDay: true,
          );
        } else if (_selectedSpecial == 'leapDay') {
          ifc = IfcDate(
            month: 0,
            day: 0,
            year: _selectedIfcYear,
            isLeapDay: true,
          );
        } else {
          ifc = IfcDate(
            month: _selectedIfcMonth,
            day: _selectedIfcDay,
            year: _selectedIfcYear,
          );
        }
        _convertedGregorianDate = ifc.toGregorian();
      } catch (_) {
        _convertedGregorianDate = null;
      }
    });
  }

  void _refreshFunFact() {
    setState(() {
      _funFact = IfcConstants.converterFunFacts[
          _random.nextInt(IfcConstants.converterFunFacts.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            // Direction toggle
            _DirectionToggle(
              gregorianToIfc: _gregorianToIfc,
              onChanged: (value) {
                setState(() => _gregorianToIfc = value);
                _refreshFunFact();
              },
            ),
            const SizedBox(height: 24),

            if (_gregorianToIfc) ...[
              _GregorianInput(
                date: _selectedGregorianDate,
                onDateChanged: (date) {
                  _selectedGregorianDate = date;
                  _convertGregorianToIfc();
                },
              ),
              const SizedBox(height: 16),
              if (_convertedIfcDate != null)
                _IfcResultCard(ifcDate: _convertedIfcDate!),
            ] else ...[
              _IfcInput(
                year: _selectedIfcYear,
                month: _selectedIfcMonth,
                day: _selectedIfcDay,
                special: _selectedSpecial,
                onYearChanged: (v) {
                  _selectedIfcYear = v;
                  _convertIfcToGregorian();
                },
                onMonthChanged: (v) {
                  _selectedIfcMonth = v;
                  _convertIfcToGregorian();
                },
                onDayChanged: (v) {
                  _selectedIfcDay = v;
                  _convertIfcToGregorian();
                },
                onSpecialChanged: (v) {
                  _selectedSpecial = v;
                  _convertIfcToGregorian();
                },
              ),
              const SizedBox(height: 16),
              if (_convertedGregorianDate != null)
                _GregorianResultCard(date: _convertedGregorianDate!),
            ],

            const SizedBox(height: 24),
            // Fun fact
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline,
                        color: AppColors.primaryPurple, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _funFact,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DirectionToggle extends StatelessWidget {
  final bool gregorianToIfc;
  final ValueChanged<bool> onChanged;

  const _DirectionToggle({
    required this.gregorianToIfc,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: _ToggleButton(
              label: 'Gregorian → IFC',
              isSelected: gregorianToIfc,
              onTap: () => onChanged(true),
            ),
          ),
          Expanded(
            child: _ToggleButton(
              label: 'IFC → Gregorian',
              isSelected: !gregorianToIfc,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ToggleButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : null,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class _GregorianInput extends StatelessWidget {
  final DateTime date;
  final ValueChanged<DateTime> onDateChanged;

  const _GregorianInput({
    required this.date,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime(1900),
            lastDate: DateTime(2200),
          );
          if (picked != null) onDateChanged(picked);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(Icons.calendar_today, color: AppColors.primaryPurple),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gregorian Date',
                      style: theme.textTheme.labelMedium),
                  const SizedBox(height: 4),
                  Text(
                    '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.edit, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _IfcResultCard extends StatelessWidget {
  final IfcDate ifcDate;

  const _IfcResultCard({required this.ifcDate});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryPurple.withValues(alpha: 0.08),
              AppColors.primaryPurple.withValues(alpha: 0.02),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'IFC Date',
              style: theme.textTheme.labelMedium?.copyWith(
                color: AppColors.primaryPurple,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              ifcDate.formatted,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${ifcDate.year}',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            if (!ifcDate.isYearDay && !ifcDate.isLeapDay) ...[
              Text(
                'Month ${ifcDate.month} of 13  •  Week ${ifcDate.weekOfMonth} of 4',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.primaryPurple,
                ),
              ),
            ] else ...[
              Text(
                ifcDate.isYearDay
                    ? 'Outside any month — a universal holiday'
                    : 'Between June and Sol — outside the week',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.specialDayGreen,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _IfcInput extends StatelessWidget {
  final int year;
  final int month;
  final int day;
  final String special;
  final ValueChanged<int> onYearChanged;
  final ValueChanged<int> onMonthChanged;
  final ValueChanged<int> onDayChanged;
  final ValueChanged<String> onSpecialChanged;

  const _IfcInput({
    required this.year,
    required this.month,
    required this.day,
    required this.special,
    required this.onYearChanged,
    required this.onMonthChanged,
    required this.onDayChanged,
    required this.onSpecialChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLeap = IfcDate.isLeapYear(year);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('IFC Date', style: theme.textTheme.labelMedium),
            const SizedBox(height: 12),
            // Year
            Row(
              children: [
                const SizedBox(width: 80, child: Text('Year')),
                Expanded(
                  child: _NumberPicker(
                    value: year,
                    min: 1900,
                    max: 2200,
                    onChanged: onYearChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Special day toggle
            Row(
              children: [
                const SizedBox(width: 80, child: Text('Type')),
                Expanded(
                  child: DropdownButton<String>(
                    value: special,
                    isExpanded: true,
                    items: [
                      const DropdownMenuItem(
                        value: 'none',
                        child: Text('Regular day'),
                      ),
                      const DropdownMenuItem(
                        value: 'yearDay',
                        child: Text('Year Day'),
                      ),
                      if (isLeap)
                        const DropdownMenuItem(
                          value: 'leapDay',
                          child: Text('Leap Day'),
                        ),
                    ],
                    onChanged: (v) {
                      if (v != null) onSpecialChanged(v);
                    },
                  ),
                ),
              ],
            ),
            if (special == 'none') ...[
              const SizedBox(height: 8),
              // Month
              Row(
                children: [
                  const SizedBox(width: 80, child: Text('Month')),
                  Expanded(
                    child: DropdownButton<int>(
                      value: month,
                      isExpanded: true,
                      items: List.generate(13, (i) {
                        final m = i + 1;
                        return DropdownMenuItem(
                          value: m,
                          child: Text('$m — ${IfcDate.monthNames[m]}'),
                        );
                      }),
                      onChanged: (v) {
                        if (v != null) onMonthChanged(v);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Day
              Row(
                children: [
                  const SizedBox(width: 80, child: Text('Day')),
                  Expanded(
                    child: _NumberPicker(
                      value: day,
                      min: 1,
                      max: 28,
                      onChanged: onDayChanged,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NumberPicker extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  const _NumberPicker({
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove, size: 18),
          onPressed: value > min ? () => onChanged(value - 1) : null,
        ),
        Expanded(
          child: Center(
            child: Text(
              '$value',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add, size: 18),
          onPressed: value < max ? () => onChanged(value + 1) : null,
        ),
      ],
    );
  }
}

class _GregorianResultCard extends StatelessWidget {
  final DateTime date;

  const _GregorianResultCard({required this.date});

  static const _months = [
    '', 'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  static const _weekdays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday',
    'Friday', 'Saturday', 'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gregorian Date',
              style: theme.textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '${_weekdays[date.weekday - 1]}, ${_months[date.month]} ${date.day}',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${date.year}',
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
