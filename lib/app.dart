import 'package:flutter/material.dart';
import 'package:thirteen_months/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'state/app_state.dart';
import 'screens/shell_screen.dart';
import 'onboarding/onboarding_screen.dart';

class ThirteenMonthsApp extends StatelessWidget {
  const ThirteenMonthsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return MaterialApp(
      title: '13 Months',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      locale: appState.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
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
