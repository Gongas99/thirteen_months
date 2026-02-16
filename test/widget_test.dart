import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thirteen_months/widgets/ifc_date_display.dart';
import 'package:thirteen_months/widgets/gregorian_date_display.dart';
import 'package:thirteen_months/core/ifc_date.dart';

void main() {
  testWidgets('IFC date display renders correctly', (WidgetTester tester) async {
    const ifc = IfcDate(month: 2, day: 19, year: 2026);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: IfcDateDisplay(ifcDate: ifc)),
      ),
    );

    expect(find.text('13-Month Calendar'), findsOneWidget);
    expect(find.text('Thursday'), findsOneWidget);
    expect(find.text('February 19'), findsOneWidget);
    expect(find.text('2026'), findsOneWidget);
  });

  testWidgets('Gregorian date display renders correctly',
      (WidgetTester tester) async {
    final date = DateTime(2026, 2, 16);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: GregorianDateDisplay(date: date)),
      ),
    );

    expect(find.text('Your calendar'), findsOneWidget);
    expect(find.text('Monday'), findsOneWidget);
    expect(find.text('February 16'), findsOneWidget);
    expect(find.text('2026'), findsOneWidget);
  });
}
