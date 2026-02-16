import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/ifc_date.dart';

class AppState extends ChangeNotifier {
  int _currentTabIndex = 0;
  int _calendarYear = DateTime.now().year;
  bool _hasSeenOnboarding = false;
  bool _widgetTransparent = true;
  Locale? _locale; // null = follow system
  late IfcDate _todayIfc;
  late DateTime _todayGregorian;

  AppState() {
    _todayGregorian = DateTime.now();
    _todayIfc = IfcDate.fromGregorian(_todayGregorian);
    _loadWidgetPreference();
    _loadBirthdayPromptState();
    _loadLocalePreference();
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

  // Widget transparency
  bool get widgetTransparent => _widgetTransparent;

  Future<void> setWidgetTransparent(bool value) async {
    if (_widgetTransparent != value) {
      _widgetTransparent = value;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('widgetTransparent', value);
      await _updateHomeWidget();
      notifyListeners();
    }
  }

  Future<void> _loadWidgetPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _widgetTransparent = prefs.getBool('widgetTransparent') ?? true;
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
      await HomeWidget.saveWidgetData('widget_transparent', _widgetTransparent);
      await HomeWidget.updateWidget(
        androidName: 'IfcWidgetProvider',
        iOSName: 'IfcWidget',
      );
    } catch (_) {
      // Widget may not be placed yet
    }
  }

  // Birthday prompt dismissal
  bool _birthdayPromptDismissed = false;
  bool get birthdayPromptDismissed => _birthdayPromptDismissed;

  Future<void> dismissBirthdayPrompt() async {
    _birthdayPromptDismissed = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('birthdayPromptDismissed', true);
    notifyListeners();
  }

  Future<void> _loadBirthdayPromptState() async {
    final prefs = await SharedPreferences.getInstance();
    _birthdayPromptDismissed =
        prefs.getBool('birthdayPromptDismissed') ?? false;
    notifyListeners();
  }

  // Locale
  Locale? get locale => _locale;

  static const supportedLocales = [
    Locale('en'),
    Locale('pt'),
    Locale('es'),
    Locale('fr'),
    Locale('de'),
    Locale('it'),
  ];

  Future<void> setLocale(Locale? locale) async {
    _locale = locale;
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove('locale');
    } else {
      await prefs.setString('locale', locale.languageCode);
    }
    notifyListeners();
  }

  Future<void> _loadLocalePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('locale');
    if (code != null) {
      _locale = Locale(code);
      notifyListeners();
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
