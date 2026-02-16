// Constants and educational content for the International Fixed Calendar.

class IfcConstants {
  IfcConstants._();

  // ---------------------------------------------------------------------------
  // Quick facts (for onboarding + learn screen)
  // ---------------------------------------------------------------------------

  static const List<String> quickFacts = [
    'Every month has exactly 28 days — 4 perfect weeks.',
    'There are 13 months: the extra month is called Sol, between June and July.',
    'Year Day (December 29) sits outside any month or week — a universal holiday.',
    'In leap years, Leap Day falls between June and Sol — also outside the week.',
  ];

  // ---------------------------------------------------------------------------
  // History timeline
  // ---------------------------------------------------------------------------

  static const List<TimelineEntry> historyTimeline = [
    TimelineEntry(
      year: '1902',
      title: 'Moses Cotsworth proposes the IFC',
      description:
          'British accountant Moses B. Cotsworth publishes "The Rational Almanac", '
          'proposing a 13-month calendar for simpler business accounting.',
    ),
    TimelineEntry(
      year: '1922',
      title: 'League of Nations considers calendar reform',
      description:
          'The League of Nations establishes a committee to study calendar reform, '
          'with the IFC as a leading candidate.',
    ),
    TimelineEntry(
      year: '1928',
      title: 'George Eastman adopts the IFC',
      description:
          'Kodak founder George Eastman adopts the IFC for Kodak\'s internal '
          'accounting. The company uses it until 1989.',
    ),
    TimelineEntry(
      year: '1937',
      title: 'UN vote falls short',
      description:
          'The League of Nations vote on the IFC fails to achieve unanimous '
          'approval, largely due to religious objections about breaking the '
          '7-day Sabbath cycle.',
    ),
    TimelineEntry(
      year: '1989',
      title: 'Kodak discontinues IFC use',
      description:
          'After over 60 years, Kodak stops using the International Fixed '
          'Calendar for internal operations.',
    ),
    TimelineEntry(
      year: 'Now',
      title: 'Growing interest online',
      description:
          'The IFC has found new popularity through social media and websites '
          'like 13months.net, with advocates highlighting its simplicity.',
    ),
  ];

  // ---------------------------------------------------------------------------
  // FAQ
  // ---------------------------------------------------------------------------

  static const List<FaqEntry> faq = [
    FaqEntry(
      question: 'Why 13 months?',
      answer:
          '13 × 28 = 364 days, just one short of a regular year. Each month has '
          'exactly 4 weeks, making scheduling, billing, and planning perfectly '
          'regular. The remaining day becomes Year Day, a special holiday.',
    ),
    FaqEntry(
      question: 'What is Sol?',
      answer:
          'Sol is the 7th month, inserted between June and July. It\'s named '
          'after the Sun (Latin "sol"). In the IFC, the months after June shift: '
          'Sol, July, August, September, October, November, December.',
    ),
    FaqEntry(
      question: 'What is Year Day?',
      answer:
          'Year Day falls after December 28 (the last regular day) and before '
          'January 1 of the next year. It belongs to no month and no weekday — '
          'it\'s a universal day off, ensuring every year starts on Sunday.',
    ),
    FaqEntry(
      question: 'How do leap years work?',
      answer:
          'Leap years follow the same rules as the Gregorian calendar (every 4 '
          'years, except centuries not divisible by 400). The extra day, Leap Day, '
          'is inserted between June 28 and Sol 1. Like Year Day, it has no weekday.',
    ),
    FaqEntry(
      question: 'What day of the week is my birthday?',
      answer:
          'In the IFC, every date falls on the same weekday every year! If your '
          'IFC birthday is the 15th, it\'s always a Sunday. Use the Converter tab '
          'to find your IFC birthday.',
    ),
    FaqEntry(
      question: 'Could this calendar actually be adopted?',
      answer:
          'The biggest obstacle is tradition and the disruption of the continuous '
          '7-day Sabbath cycle. Year Day and Leap Day break the weekly pattern, '
          'which some religious traditions consider unacceptable. Despite this, '
          'the IFC remains one of the most practical calendar reform proposals.',
    ),
  ];

  // ---------------------------------------------------------------------------
  // Converter fun facts
  // ---------------------------------------------------------------------------

  static const List<String> converterFunFacts = [
    'In the IFC, every month starts on Sunday and ends on Saturday.',
    'Friday the 13th occurs every month in the IFC!',
    'Your IFC birthday is always on the same weekday, every year.',
    'Kodak used the IFC internally for over 60 years (1928–1989).',
    'The 13th month, Sol, is named after the Latin word for Sun.',
    '13 × 28 = 364. Add Year Day (and Leap Day) to complete the year.',
    'George Eastman was the IFC\'s biggest corporate champion.',
    'Every IFC quarter has exactly 91 days (13 weeks).',
  ];
}

class TimelineEntry {
  final String year;
  final String title;
  final String description;

  const TimelineEntry({
    required this.year,
    required this.title,
    required this.description,
  });
}

class FaqEntry {
  final String question;
  final String answer;

  const FaqEntry({
    required this.question,
    required this.answer,
  });
}
