// International Fixed Calendar date model and conversion logic.
//
// The IFC has 13 months of exactly 28 days each (364 days), plus:
// - Year Day: Dec 29 (Gregorian) — outside any month/week
// - Leap Day: Jun 17 (Gregorian) in leap years — between Sol and month 7 (Sol)

class IfcDate {
  /// IFC month (1–13), or 0 for special days.
  final int month;

  /// IFC day within the month (1–28), or 0 for special days.
  final int day;

  /// Gregorian year (IFC year matches Gregorian year).
  final int year;

  /// True if this date is Year Day (last day of the year).
  final bool isYearDay;

  /// True if this date is Leap Day (only in leap years).
  final bool isLeapDay;

  const IfcDate({
    required this.month,
    required this.day,
    required this.year,
    this.isYearDay = false,
    this.isLeapDay = false,
  });

  // ---------------------------------------------------------------------------
  // IFC month names
  // ---------------------------------------------------------------------------

  static const List<String> monthNames = [
    '', // 0-indexed placeholder
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'Sol',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const List<String> weekdayNames = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  static const List<String> weekdayAbbreviations = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  static bool isLeapYear(int year) {
    if (year % 400 == 0) return true;
    if (year % 100 == 0) return false;
    if (year % 4 == 0) return true;
    return false;
  }

  static int _daysInGregorianYear(int year) =>
      isLeapYear(year) ? 366 : 365;

  /// Day of year (1-based ordinal) for a Gregorian date.
  static int _dayOfYear(DateTime date) {
    // Use cumulative days per month to avoid DST issues with Duration math.
    const cumDays = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    int ordinal = cumDays[date.month - 1] + date.day;
    if (date.month > 2 && isLeapYear(date.year)) ordinal += 1;
    return ordinal;
  }

  /// Gregorian date from year + ordinal day.
  static DateTime _dateFromOrdinal(int year, int ordinal) {
    // Use DateTime constructor to avoid DST issues.
    const daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    int remaining = ordinal;
    for (int m = 0; m < 12; m++) {
      int dim = daysInMonth[m];
      if (m == 1 && isLeapYear(year)) dim += 1;
      if (remaining <= dim) {
        return DateTime(year, m + 1, remaining);
      }
      remaining -= dim;
    }
    // Should not reach here for valid ordinals
    return DateTime(year, 12, 31);
  }

  // ---------------------------------------------------------------------------
  // Gregorian → IFC
  // ---------------------------------------------------------------------------

  factory IfcDate.fromGregorian(DateTime date) {
    // Normalize to date-only
    final d = DateTime(date.year, date.month, date.day);
    final year = d.year;
    final ordinal = _dayOfYear(d);
    final totalDays = _daysInGregorianYear(year);
    final leap = isLeapYear(year);

    // Year Day: last day of the year
    if (ordinal == totalDays) {
      return IfcDate(month: 0, day: 0, year: year, isYearDay: true);
    }

    // Leap Day: ordinal 169 in a leap year (June 17 Gregorian)
    if (leap && ordinal == 169) {
      return IfcDate(month: 0, day: 0, year: year, isLeapDay: true);
    }

    // Adjust ordinal for regular day calculation
    int regularDay = ordinal;
    if (leap && ordinal > 169) {
      regularDay = ordinal - 1;
    }

    final ifcMonth = ((regularDay - 1) ~/ 28) + 1;
    final ifcDay = ((regularDay - 1) % 28) + 1;

    return IfcDate(month: ifcMonth, day: ifcDay, year: year);
  }

  // ---------------------------------------------------------------------------
  // IFC → Gregorian
  // ---------------------------------------------------------------------------

  DateTime toGregorian() {
    final leap = isLeapYear(year);
    final totalDays = _daysInGregorianYear(year);

    if (isYearDay) {
      return _dateFromOrdinal(year, totalDays);
    }

    if (isLeapDay) {
      assert(leap, 'Leap Day only exists in leap years');
      return _dateFromOrdinal(year, 169);
    }

    int ordinal = (month - 1) * 28 + day;

    if (leap && ordinal > 168) {
      ordinal += 1; // Skip over Leap Day slot
    }

    return _dateFromOrdinal(year, ordinal);
  }

  // ---------------------------------------------------------------------------
  // Day of week
  // ---------------------------------------------------------------------------

  /// IFC weekday index: 0 = Sunday, 6 = Saturday.
  /// Every IFC month starts on Sunday, so weekday = (day - 1) % 7.
  /// Special days (Year Day, Leap Day) are outside the week.
  int get weekdayIndex {
    if (isYearDay || isLeapDay) return -1; // Not part of the week
    return (day - 1) % 7;
  }

  String get weekdayName {
    if (isYearDay) return 'Year Day';
    if (isLeapDay) return 'Leap Day';
    return weekdayNames[weekdayIndex];
  }

  String get weekdayAbbreviation {
    if (isYearDay) return 'YD';
    if (isLeapDay) return 'LD';
    return weekdayAbbreviations[weekdayIndex];
  }

  /// Human-readable month name.
  String get monthName {
    if (isYearDay) return 'Year Day';
    if (isLeapDay) return 'Leap Day';
    return monthNames[month];
  }

  /// Week number within the month (1–4).
  int get weekOfMonth {
    if (isYearDay || isLeapDay) return 0;
    return ((day - 1) ~/ 7) + 1;
  }

  /// Formatted display: "Thursday, February 19"
  String get formatted {
    if (isYearDay) return 'Year Day';
    if (isLeapDay) return 'Leap Day';
    return '$weekdayName, $monthName $day';
  }

  /// Short format: "Thu, Feb 19"
  String get shortFormatted {
    if (isYearDay) return 'Year Day';
    if (isLeapDay) return 'Leap Day';
    final shortMonth = monthName.length > 3
        ? monthName.substring(0, 3)
        : monthName;
    return '$weekdayAbbreviation, $shortMonth $day';
  }

  @override
  String toString() => 'IfcDate($year-${isYearDay ? "YD" : isLeapDay ? "LD" : "$month-$day"})';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IfcDate &&
          month == other.month &&
          day == other.day &&
          year == other.year &&
          isYearDay == other.isYearDay &&
          isLeapDay == other.isLeapDay;

  @override
  int get hashCode => Object.hash(month, day, year, isYearDay, isLeapDay);
}
