import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../core/theme.dart';

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
    final hour = _twoDigits(_now.hour);
    final minute = _twoDigits(_now.minute);
    final second = _twoDigits(_now.second);
    final colonVisible = _now.second % 2 == 0;

    final bigStyle = theme.textTheme.displayLarge?.copyWith(
      fontWeight: FontWeight.w200,
      fontSize: 64,
      letterSpacing: 2,
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    final colonStyle = bigStyle?.copyWith(
      color: colonVisible
          ? null
          : (theme.textTheme.displayLarge?.color ?? Colors.white)
              .withValues(alpha: 0.2),
    );

    final secondStyle = theme.textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w300,
      color: AppColors.primaryPurple.withValues(alpha: 0.7),
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(hour, style: bigStyle),
        Text(':', style: colonStyle),
        Text(minute, style: bigStyle),
        const SizedBox(width: 6),
        Text(second, style: secondStyle),
      ],
    );
  }
}
