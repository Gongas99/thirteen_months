import 'package:thirteen_months/l10n/app_localizations.dart';

/// Helper to get localized IFC month/weekday names from AppLocalizations.
/// Use this in UI code instead of IfcDate.monthNames / IfcDate.weekdayNames.
class IfcLocalizations {
  IfcLocalizations._();

  /// Localized IFC month name (1-based index, 1–13).
  static String monthName(AppLocalizations l10n, int month) {
    const names = [
      '', // 0 placeholder
      'monthJanuary',
      'monthFebruary',
      'monthMarch',
      'monthApril',
      'monthMay',
      'monthJune',
      'monthSol',
      'monthJuly',
      'monthAugust',
      'monthSeptember',
      'monthOctober',
      'monthNovember',
      'monthDecember',
    ];
    return _monthLookup(l10n)[month] ?? names[month];
  }

  static Map<int, String> _monthLookup(AppLocalizations l10n) => {
        1: l10n.monthJanuary,
        2: l10n.monthFebruary,
        3: l10n.monthMarch,
        4: l10n.monthApril,
        5: l10n.monthMay,
        6: l10n.monthJune,
        7: l10n.monthSol,
        8: l10n.monthJuly,
        9: l10n.monthAugust,
        10: l10n.monthSeptember,
        11: l10n.monthOctober,
        12: l10n.monthNovember,
        13: l10n.monthDecember,
      };

  /// Localized IFC weekday name (0 = Sunday, 6 = Saturday).
  static String weekdayName(AppLocalizations l10n, int index) {
    return _weekdayLookup(l10n)[index] ?? '';
  }

  static Map<int, String> _weekdayLookup(AppLocalizations l10n) => {
        0: l10n.weekdaySunday,
        1: l10n.weekdayMonday,
        2: l10n.weekdayTuesday,
        3: l10n.weekdayWednesday,
        4: l10n.weekdayThursday,
        5: l10n.weekdayFriday,
        6: l10n.weekdaySaturday,
      };

  /// Localized IFC weekday abbreviation (0 = Sun, 6 = Sat).
  static String weekdayAbbr(AppLocalizations l10n, int index) {
    return _weekdayAbbrLookup(l10n)[index] ?? '';
  }

  static Map<int, String> _weekdayAbbrLookup(AppLocalizations l10n) => {
        0: l10n.weekdayAbbrSun,
        1: l10n.weekdayAbbrMon,
        2: l10n.weekdayAbbrTue,
        3: l10n.weekdayAbbrWed,
        4: l10n.weekdayAbbrThu,
        5: l10n.weekdayAbbrFri,
        6: l10n.weekdayAbbrSat,
      };

  /// All 7 localized weekday abbreviations in order (Sun–Sat).
  static List<String> weekdayAbbreviations(AppLocalizations l10n) => [
        l10n.weekdayAbbrSun,
        l10n.weekdayAbbrMon,
        l10n.weekdayAbbrTue,
        l10n.weekdayAbbrWed,
        l10n.weekdayAbbrThu,
        l10n.weekdayAbbrFri,
        l10n.weekdayAbbrSat,
      ];

  /// Localized Gregorian weekday name (1 = Monday, 7 = Sunday — DateTime.weekday).
  static String gregWeekday(AppLocalizations l10n, int weekday) {
    return _gregWeekdayLookup(l10n)[weekday] ?? '';
  }

  static Map<int, String> _gregWeekdayLookup(AppLocalizations l10n) => {
        1: l10n.gregWeekdayMonday,
        2: l10n.gregWeekdayTuesday,
        3: l10n.gregWeekdayWednesday,
        4: l10n.gregWeekdayThursday,
        5: l10n.gregWeekdayFriday,
        6: l10n.gregWeekdaySaturday,
        7: l10n.gregWeekdaySunday,
      };

  /// Localized Gregorian month name (1-based, 1–12).
  static String gregMonth(AppLocalizations l10n, int month) {
    return _gregMonthLookup(l10n)[month] ?? '';
  }

  static Map<int, String> _gregMonthLookup(AppLocalizations l10n) => {
        1: l10n.gregMonthJanuary,
        2: l10n.gregMonthFebruary,
        3: l10n.gregMonthMarch,
        4: l10n.gregMonthApril,
        5: l10n.gregMonthMay,
        6: l10n.gregMonthJune,
        7: l10n.gregMonthJuly,
        8: l10n.gregMonthAugust,
        9: l10n.gregMonthSeptember,
        10: l10n.gregMonthOctober,
        11: l10n.gregMonthNovember,
        12: l10n.gregMonthDecember,
      };

  /// List of localized fun facts (for Today screen rotation).
  static List<String> funFacts(AppLocalizations l10n) => [
        l10n.funFact1,
        l10n.funFact2,
        l10n.funFact3,
        l10n.funFact4,
        l10n.funFact5,
        l10n.funFact6,
        l10n.funFact7,
        l10n.funFact8,
      ];

  /// List of localized quick facts (for learn screen / onboarding).
  static List<String> quickFacts(AppLocalizations l10n) => [
        l10n.quickFact1,
        l10n.quickFact2,
        l10n.quickFact3,
        l10n.quickFact4,
      ];
}
