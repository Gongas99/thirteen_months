import 'package:flutter_test/flutter_test.dart';
import 'package:thirteen_months/core/ifc_date.dart';

void main() {
  group('Leap year detection', () {
    test('2024 is a leap year', () {
      expect(IfcDate.isLeapYear(2024), isTrue);
    });

    test('2025 is not a leap year', () {
      expect(IfcDate.isLeapYear(2025), isFalse);
    });

    test('2000 is a leap year (divisible by 400)', () {
      expect(IfcDate.isLeapYear(2000), isTrue);
    });

    test('1900 is not a leap year (divisible by 100 but not 400)', () {
      expect(IfcDate.isLeapYear(1900), isFalse);
    });

    test('2100 is not a leap year', () {
      expect(IfcDate.isLeapYear(2100), isFalse);
    });
  });

  group('Gregorian → IFC: Known reference', () {
    test('Feb 16, 2026 → Thursday, February 19 (from 13months.net)', () {
      final ifc = IfcDate.fromGregorian(DateTime(2026, 2, 16));
      expect(ifc.month, 2);
      expect(ifc.day, 19);
      expect(ifc.year, 2026);
      expect(ifc.weekdayName, 'Thursday');
    });
  });

  group('Gregorian → IFC: Boundaries', () {
    test('January 1 → month 1, day 1 (Sunday)', () {
      final ifc = IfcDate.fromGregorian(DateTime(2025, 1, 1));
      expect(ifc.month, 1);
      expect(ifc.day, 1);
      expect(ifc.weekdayName, 'Sunday');
    });

    test('January 28 → month 1, day 28 (Saturday)', () {
      final ifc = IfcDate.fromGregorian(DateTime(2025, 1, 28));
      expect(ifc.month, 1);
      expect(ifc.day, 28);
      expect(ifc.weekdayName, 'Saturday');
    });

    test('January 29 → month 2, day 1 (Sunday)', () {
      final ifc = IfcDate.fromGregorian(DateTime(2025, 1, 29));
      expect(ifc.month, 2);
      expect(ifc.day, 1);
      expect(ifc.weekdayName, 'Sunday');
    });

    test('December 31, 2025 (non-leap) → Year Day', () {
      final ifc = IfcDate.fromGregorian(DateTime(2025, 12, 31));
      expect(ifc.isYearDay, isTrue);
      expect(ifc.weekdayName, 'Year Day');
    });

    test('December 30, 2025 → month 13, day 28', () {
      final ifc = IfcDate.fromGregorian(DateTime(2025, 12, 30));
      expect(ifc.month, 13);
      expect(ifc.day, 28);
    });
  });

  group('Gregorian → IFC: Leap year', () {
    test('June 17, 2024 → Leap Day', () {
      final ifc = IfcDate.fromGregorian(DateTime(2024, 6, 17));
      expect(ifc.isLeapDay, isTrue);
      expect(ifc.weekdayName, 'Leap Day');
    });

    test('June 16, 2024 → month 6, day 28 (day before Leap Day)', () {
      final ifc = IfcDate.fromGregorian(DateTime(2024, 6, 16));
      expect(ifc.month, 6);
      expect(ifc.day, 28);
    });

    test('June 18, 2024 → month 7, day 1 (Sol 1, day after Leap Day)', () {
      final ifc = IfcDate.fromGregorian(DateTime(2024, 6, 18));
      expect(ifc.month, 7);
      expect(ifc.day, 1);
    });

    test('December 31, 2024 (leap) → Year Day', () {
      final ifc = IfcDate.fromGregorian(DateTime(2024, 12, 31));
      expect(ifc.isYearDay, isTrue);
    });

    test('December 30, 2024 → month 13, day 28', () {
      final ifc = IfcDate.fromGregorian(DateTime(2024, 12, 30));
      expect(ifc.month, 13);
      expect(ifc.day, 28);
    });
  });

  group('Gregorian → IFC: Sol month', () {
    test('First day of Sol in non-leap year', () {
      // Day 169 in non-leap year
      // (month 7, day 1) → ordinal 169
      final date = DateTime(2025, 1, 1).add(const Duration(days: 168)); // ordinal 169
      final ifc = IfcDate.fromGregorian(date);
      expect(ifc.month, 7);
      expect(ifc.day, 1);
      expect(ifc.monthName, 'Sol');
    });
  });

  group('IFC → Gregorian', () {
    test('month 1, day 1 → January 1', () {
      final greg =
          const IfcDate(month: 1, day: 1, year: 2025).toGregorian();
      expect(greg, DateTime(2025, 1, 1));
    });

    test('Year Day → December 31 (non-leap)', () {
      final greg = const IfcDate(
        month: 0,
        day: 0,
        year: 2025,
        isYearDay: true,
      ).toGregorian();
      expect(greg, DateTime(2025, 12, 31));
    });

    test('Year Day → December 31 (leap)', () {
      final greg = const IfcDate(
        month: 0,
        day: 0,
        year: 2024,
        isYearDay: true,
      ).toGregorian();
      expect(greg, DateTime(2024, 12, 31));
    });

    test('Leap Day → June 17 (leap year)', () {
      final greg = const IfcDate(
        month: 0,
        day: 0,
        year: 2024,
        isLeapDay: true,
      ).toGregorian();
      expect(greg, DateTime(2024, 6, 17));
    });

    test('Sol 1 (month 7, day 1) in leap year → June 18', () {
      final greg =
          const IfcDate(month: 7, day: 1, year: 2024).toGregorian();
      expect(greg, DateTime(2024, 6, 18));
    });

    test('Month 13, day 28 → December 30 (non-leap)', () {
      final greg =
          const IfcDate(month: 13, day: 28, year: 2025).toGregorian();
      expect(greg, DateTime(2025, 12, 30));
    });
  });

  group('Round-trip: every day of 2025 (non-leap)', () {
    test('Gregorian → IFC → Gregorian for all 365 days', () {
      for (int m = 1; m <= 12; m++) {
        final daysInMonth = DateTime(2025, m + 1, 0).day;
        for (int d = 1; d <= daysInMonth; d++) {
          final date = DateTime(2025, m, d);
          final ifc = IfcDate.fromGregorian(date);
          final roundTrip = ifc.toGregorian();
          expect(
            roundTrip,
            date,
            reason: 'Round-trip failed for $date → $ifc',
          );
        }
      }
    });
  });

  group('Round-trip: every day of 2024 (leap)', () {
    test('Gregorian → IFC → Gregorian for all 366 days', () {
      for (int m = 1; m <= 12; m++) {
        final daysInMonth = DateTime(2024, m + 1, 0).day;
        for (int d = 1; d <= daysInMonth; d++) {
          final date = DateTime(2024, m, d);
          final ifc = IfcDate.fromGregorian(date);
          final roundTrip = ifc.toGregorian();
          expect(
            roundTrip,
            date,
            reason: 'Round-trip failed for $date → $ifc',
          );
        }
      }
    });
  });

  group('Day of week', () {
    test('Day 1 is always Sunday', () {
      final ifc = const IfcDate(month: 5, day: 1, year: 2025);
      expect(ifc.weekdayIndex, 0);
      expect(ifc.weekdayName, 'Sunday');
    });

    test('Day 7 is always Saturday', () {
      final ifc = const IfcDate(month: 3, day: 7, year: 2025);
      expect(ifc.weekdayIndex, 6);
      expect(ifc.weekdayName, 'Saturday');
    });

    test('Day 13 is always Friday', () {
      final ifc = const IfcDate(month: 1, day: 13, year: 2025);
      expect(ifc.weekdayIndex, 5);
      expect(ifc.weekdayName, 'Friday');
    });

    test('Day 28 is always Saturday', () {
      final ifc = const IfcDate(month: 10, day: 28, year: 2025);
      expect(ifc.weekdayIndex, 6);
      expect(ifc.weekdayName, 'Saturday');
    });
  });

  group('Formatting', () {
    test('Regular date formatted correctly', () {
      final ifc = const IfcDate(month: 2, day: 19, year: 2026);
      expect(ifc.formatted, 'Thursday, February 19');
      expect(ifc.shortFormatted, 'Thu, Feb 19');
    });

    test('Year Day formatted correctly', () {
      final ifc = const IfcDate(
        month: 0,
        day: 0,
        year: 2025,
        isYearDay: true,
      );
      expect(ifc.formatted, 'Year Day');
      expect(ifc.shortFormatted, 'Year Day');
    });

    test('Sol month name', () {
      final ifc = const IfcDate(month: 7, day: 15, year: 2025);
      expect(ifc.monthName, 'Sol');
    });
  });

  group('Equality', () {
    test('Same dates are equal', () {
      const a = IfcDate(month: 5, day: 10, year: 2025);
      const b = IfcDate(month: 5, day: 10, year: 2025);
      expect(a, equals(b));
    });

    test('Different dates are not equal', () {
      const a = IfcDate(month: 5, day: 10, year: 2025);
      const b = IfcDate(month: 5, day: 11, year: 2025);
      expect(a, isNot(equals(b)));
    });
  });
}
