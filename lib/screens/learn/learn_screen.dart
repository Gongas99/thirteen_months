import 'package:flutter/material.dart';
import '../../core/ifc_constants.dart';
import '../../core/theme.dart';
import '../../widgets/month_grid.dart';
import '../../widgets/timeline_item.dart';
import '../../widgets/faq_tile.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'The whole idea\nin 30 seconds',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Quick facts
            ...IfcConstants.quickFacts.map((fact) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle,
                          color: AppColors.primaryPurple, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(fact, style: theme.textTheme.bodyMedium),
                      ),
                    ],
                  ),
                )),

            const SizedBox(height: 24),

            // Generic month grid
            Text(
              'Every month looks like this',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: MonthGrid(
                  month: 1,
                  year: DateTime.now().year,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // History timeline
            Text(
              'History',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ...IfcConstants.historyTimeline.asMap().entries.map((entry) {
              final item = entry.value;
              final isLast =
                  entry.key == IfcConstants.historyTimeline.length - 1;
              return TimelineItem(
                year: item.year,
                title: item.title,
                description: item.description,
                isLast: isLast,
              );
            }),

            const SizedBox(height: 24),

            // FAQ
            Text(
              'FAQ',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ...IfcConstants.faq.map((entry) => FaqTile(
                  question: entry.question,
                  answer: entry.answer,
                )),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
