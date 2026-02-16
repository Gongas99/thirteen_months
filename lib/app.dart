import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'state/app_state.dart';
import 'screens/shell_screen.dart';
import 'onboarding/onboarding_screen.dart';

class ThirteenMonthsApp extends StatelessWidget {
  const ThirteenMonthsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '13 Months',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: Consumer<AppState>(
        builder: (context, state, _) {
          if (!state.hasSeenOnboarding) {
            return const OnboardingScreen();
          }
          return const ShellScreen();
        },
      ),
    );
  }
}
