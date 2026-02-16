import 'package:flutter/material.dart';
import 'package:thirteen_months/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import 'today/today_screen.dart';
import 'calendar/calendar_screen.dart';
import 'converter/converter_screen.dart';
import 'learn/learn_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> with WidgetsBindingObserver {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<AppState>().refreshToday();
    }
  }

  int _previousTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final l10n = AppLocalizations.of(context);

    // Sync page controller when tab index changes programmatically
    if (appState.currentTabIndex != _previousTabIndex) {
      _previousTabIndex = appState.currentTabIndex;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_pageController.hasClients &&
            _pageController.page?.round() != appState.currentTabIndex) {
          _pageController.animateToPage(
            appState.currentTabIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    }

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _previousTabIndex = index;
          appState.currentTabIndex = index;
        },
        children: const [
          TodayScreen(),
          CalendarScreen(),
          ConverterScreen(),
          LearnScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: appState.currentTabIndex,
        onTap: (index) {
          appState.currentTabIndex = index;
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.today),
            label: l10n.tabToday,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_month),
            label: l10n.tabCalendar,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.swap_horiz),
            label: l10n.tabConverter,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.school),
            label: l10n.tabLearn,
          ),
        ],
      ),
    );
  }
}
