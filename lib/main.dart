import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/app_state.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appState = AppState();
  await appState.loadOnboardingState();

  runApp(
    ChangeNotifierProvider.value(
      value: appState,
      child: const ThirteenMonthsApp(),
    ),
  );
}
