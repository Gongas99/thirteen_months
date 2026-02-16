import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/ifc_date.dart';

class AppState extends ChangeNotifier {
  int _currentTabIndex = 0;
  int _calendarYear = DateTime.now().year;
  bool _hasSeenOnboarding = false;
  late IfcDate _todayIfc;
  late DateTime _todayGregorian;

  AppState() {
    _todayGregorian = DateTime.now();
    _todayIfc = IfcDate.fromGregorian(_todayGregorian);
    _updateHomeWidget();
  }

  // Tab navigation
  int get currentTabIndex => _currentTabIndex;
  set currentTabIndex(int value) {
    if (_currentTabIndex != value) {
      _currentTabIndex = value;
      notifyListeners();
    }
  }

  // Calendar year
  int get calendarYear => _calendarYear;
  void setCalendarYear(int year) {
    _calendarYear = year;
    notifyListeners();
  }

  void nextYear() => setCalendarYear(_calendarYear + 1);
  void previousYear() => setCalendarYear(_calendarYear - 1);

  // Today
  IfcDate get todayIfc => _todayIfc;
  DateTime get todayGregorian => _todayGregorian;

  void refreshToday() {
    _todayGregorian = DateTime.now();
    _todayIfc = IfcDate.fromGregorian(_todayGregorian);
    _updateHomeWidget();
    notifyListeners();
  }

  Future<void> _updateHomeWidget() async {
    try {
      // IFC date: "Weekday, DD/MM" or special day name
      final ifcDateText = _todayIfc.isYearDay
          ? 'Year Day'
          : _todayIfc.isLeapDay
              ? 'Leap Day'
              : '${_todayIfc.weekdayName}, ${_todayIfc.day}/${_todayIfc.month.toString().padLeft(2, '0')}';
      await HomeWidget.saveWidgetData('ifc_date_text', ifcDateText);
      // Gregorian date: "Weekday, DD/MM" for large widget layout
      const weekdays = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
      final g = _todayGregorian;
      final gregWeekday = weekdays[g.weekday - 1];
      await HomeWidget.saveWidgetData('gregorian_date_text',
          '$gregWeekday, ${g.day}/${g.month.toString().padLeft(2, '0')}');
      await HomeWidget.updateWidget(
        androidName: 'IfcWidgetProvider',
        iOSName: 'IfcWidget',
      );
    } catch (_) {
      // Widget may not be placed yet
    }
  }

  // Onboarding
  bool get hasSeenOnboarding => _hasSeenOnboarding;

  Future<void> loadOnboardingState() async {
    final prefs = await SharedPreferences.getInstance();
    _hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    _hasSeenOnboarding = true;
    notifyListeners();
  }
}
