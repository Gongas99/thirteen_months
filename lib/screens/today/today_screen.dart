import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thirteen_months/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../l10n/ifc_localizations.dart';
import '../../state/app_state.dart';
import '../../core/theme.dart';
import '../../widgets/clock_widget.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  int _funFactIndex = Random().nextInt(8);

  void _nextFunFact() {
    setState(() {
      _funFactIndex = (_funFactIndex + 1 + Random().nextInt(7)) % 8;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => _showSettingsSheet(context),
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
        elevation: 2,
        child: Icon(
          Icons.settings_outlined,
          color: theme.colorScheme.onSurfaceVariant,
          size: 20,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 80),
          child: Column(
            children: [
              const ClockWidget(),
              const SizedBox(height: 40),
              _buildCalendarComparison(context, appState, l10n),
              if (!appState.birthdayPromptDismissed) ...[
                const SizedBox(height: 24),
                _buildBirthdayPrompt(context, appState, l10n),
              ],
              const SizedBox(height: 24),
              _buildFunFactCard(context, l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFunFactCard(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final facts = IfcLocalizations.funFacts(l10n);

    return GestureDetector(
      onTap: _nextFunFact,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.primaryPurple.withValues(alpha: 0.06),
          border: Border.all(
            color: AppColors.primaryPurple.withValues(alpha: 0.12),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.lightbulb_outline,
                color: AppColors.primaryPurple, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.funFactLabel,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.primaryPurple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    facts[_funFactIndex],
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.tapForNewFact,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant
                          .withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBirthdayPrompt(
      BuildContext context, AppState appState, AppLocalizations l10n) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 14, 8, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primaryPurple.withValues(alpha: 0.08),
        border: Border.all(
          color: AppColors.primaryPurple.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.cake_outlined,
            color: AppColors.primaryPurple,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () {
                appState.currentTabIndex = 2;
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.birthdayPromptTitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.birthdayPromptSubtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () => appState.dismissBirthdayPrompt(),
            icon: Icon(
              Icons.close,
              size: 18,
              color:
                  theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarComparison(
      BuildContext context, AppState appState, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final ifcDate = appState.todayIfc;
    final gregDate = appState.todayGregorian;
    final isSpecial = ifcDate.isYearDay || ifcDate.isLeapDay;
    final accentColor =
        isSpecial ? AppColors.specialDayGreen : AppColors.primaryPurple;

    final weekday = IfcLocalizations.gregWeekday(l10n, gregDate.weekday);
    final gregMonth = IfcLocalizations.gregMonth(l10n, gregDate.month);

    return Column(
      children: [
        // IFC Date — hero section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                accentColor.withValues(alpha: 0.10),
                accentColor.withValues(alpha: 0.03),
              ],
            ),
            border: Border.all(
              color: accentColor.withValues(alpha: 0.15),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  l10n.label13MonthCalendar,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (isSpecial)
                Text(
                  ifcDate.isYearDay ? l10n.yearDay : l10n.leapDay,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                )
              else ...[
                Text(
                  IfcLocalizations.weekdayName(l10n, ifcDate.weekdayIndex),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${IfcLocalizations.monthName(l10n, ifcDate.month)} ${ifcDate.day}',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${ifcDate.year}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Divider with label
        Row(
          children: [
            Expanded(
              child: Divider(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                l10n.todayIsAlso,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant
                      .withValues(alpha: 0.5),
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Gregorian Date — compact row
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: theme.colorScheme.surfaceContainerLow,
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weekday,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$gregMonth ${gregDate.day}, ${gregDate.year}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                l10n.labelGregorian,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant
                      .withValues(alpha: 0.5),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showSettingsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return Consumer<AppState>(
          builder: (_, appState, _) {
            final l10n = AppLocalizations.of(context);
            final sheetTheme = Theme.of(sheetContext);

            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 32,
                      height: 4,
                      decoration: BoxDecoration(
                        color: sheetTheme.colorScheme.onSurfaceVariant
                            .withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    l10n.settingsWidget,
                    style: sheetTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.settingsTransparentBg),
                    subtitle: Text(l10n.settingsTransparentBgDesc),
                    value: appState.widgetTransparent,
                    onChanged: (value) {
                      appState.setWidgetTransparent(value);
                    },
                  ),
                  const Divider(height: 24),
                  Text(
                    l10n.settingsLanguage,
                    style: sheetTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildLanguagePicker(sheetContext, appState, l10n),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLanguagePicker(
      BuildContext context, AppState appState, AppLocalizations l10n) {
    final currentCode = appState.locale?.languageCode;

    final options = <(String?, String)>[
      (null, l10n.languageSystem),
      ('en', l10n.languageEn),
      ('pt', l10n.languagePt),
      ('es', l10n.languageEs),
      ('fr', l10n.languageFr),
      ('de', l10n.languageDe),
      ('it', l10n.languageIt),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final code = option.$1;
        final label = option.$2;
        final isSelected = currentCode == code;

        return ChoiceChip(
          label: Text(label),
          selected: isSelected,
          onSelected: (_) {
            appState.setLocale(code == null ? null : Locale(code));
          },
        );
      }).toList(),
    );
  }
}
