import 'package:flutter/material.dart';
import 'package:thirteen_months/l10n/app_localizations.dart';
import '../../core/theme.dart';
import '../../l10n/ifc_localizations.dart';
import '../../widgets/month_grid.dart';
import '../../widgets/timeline_item.dart';
import '../../widgets/faq_tile.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    final quickFacts = IfcLocalizations.quickFacts(l10n);

    final timeline = [
      (l10n.timelineYear1, l10n.timelineTitle1, l10n.timelineDesc1),
      (l10n.timelineYear2, l10n.timelineTitle2, l10n.timelineDesc2),
      (l10n.timelineYear3, l10n.timelineTitle3, l10n.timelineDesc3),
      (l10n.timelineYear4, l10n.timelineTitle4, l10n.timelineDesc4),
      (l10n.timelineYear5, l10n.timelineTitle5, l10n.timelineDesc5),
      (l10n.timelineYear6, l10n.timelineTitle6, l10n.timelineDesc6),
    ];

    final faqItems = [
      (l10n.faq1Question, l10n.faq1Answer),
      (l10n.faq2Question, l10n.faq2Answer),
      (l10n.faq3Question, l10n.faq3Answer),
      (l10n.faq4Question, l10n.faq4Answer),
      (l10n.faq5Question, l10n.faq5Answer),
      (l10n.faq6Question, l10n.faq6Answer),
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              l10n.learnHeader,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Quick facts
            ...quickFacts.map((fact) => Padding(
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
              l10n.everyMonthLooksLikeThis,
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
              l10n.historyTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ...timeline.asMap().entries.map((entry) {
              final item = entry.value;
              final isLast = entry.key == timeline.length - 1;
              return TimelineItem(
                year: item.$1,
                title: item.$2,
                description: item.$3,
                isLast: isLast,
              );
            }),

            const SizedBox(height: 24),

            // FAQ
            Text(
              l10n.faqTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ...faqItems.map((entry) => FaqTile(
                  question: entry.$1,
                  answer: entry.$2,
                )),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
