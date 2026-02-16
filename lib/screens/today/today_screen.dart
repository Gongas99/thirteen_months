import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import '../../widgets/ifc_date_display.dart';
import '../../widgets/gregorian_date_display.dart';
import '../../widgets/clock_widget.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        child: Column(
          children: [
            IfcDateDisplay(ifcDate: appState.todayIfc),
            const SizedBox(height: 24),
            const ClockWidget(),
            const SizedBox(height: 24),
            GregorianDateDisplay(date: appState.todayGregorian),
          ],
        ),
      ),
    );
  }
}
