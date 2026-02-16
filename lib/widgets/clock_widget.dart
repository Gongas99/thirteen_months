import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  late DateTime _now;
  int _lastSecond = -1;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _lastSecond = _now.second;
    _ticker = createTicker((_) {
      final now = DateTime.now();
      if (now.second != _lastSecond) {
        _lastSecond = now.second;
        setState(() => _now = now);
      }
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timeString =
        '${_twoDigits(_now.hour)}:${_twoDigits(_now.minute)}:${_twoDigits(_now.second)}';

    return Text(
      timeString,
      style: theme.textTheme.displaySmall?.copyWith(
        fontWeight: FontWeight.w300,
        letterSpacing: 4,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }
}
