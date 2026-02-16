import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../state/app_state.dart';
import '../screens/shell_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late final AnimationController _welcomeAnimController;
  late final Animation<double> _welcomeScaleAnim;
  late final Animation<double> _welcomeFadeAnim;

  late final AnimationController _skipFadeController;
  late final Animation<double> _skipFadeAnim;

  static const _contentPages = [
    _OnboardingPageData(
      icon: Icons.calendar_month,
      title: '13 Perfect Months',
      body:
          'Every month has exactly 28 days — 4 perfect weeks. '
          'No more wondering what day the 15th falls on.',
    ),
    _OnboardingPageData(
      icon: Icons.wb_sunny,
      title: 'Meet Sol',
      body:
          'The 7th month, Sol, sits between June and July. '
          'Named after the Sun, it completes the 13-month year.',
    ),
    _OnboardingPageData(
      icon: Icons.celebration,
      title: 'Year Day & Leap Day',
      body:
          'Year Day (after Dec 28) belongs to no month or week — '
          'a universal holiday. Leap Day works the same way, '
          'falling between June and Sol.',
    ),
    _OnboardingPageData(
      icon: Icons.explore,
      title: 'Explore the Calendar',
      body:
          'See today\'s IFC date, browse all 13 months, '
          'convert dates, and learn the history. '
          'Let\'s get started!',
    ),
  ];

  // Total pages: welcome (0) + 4 content pages
  int get _totalPages => _contentPages.length + 1;

  @override
  void initState() {
    super.initState();

    // Welcome page icon cluster animation
    _welcomeAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _welcomeScaleAnim = CurvedAnimation(
      parent: _welcomeAnimController,
      curve: Curves.elasticOut,
    );
    _welcomeFadeAnim = CurvedAnimation(
      parent: _welcomeAnimController,
      curve: Curves.easeIn,
    );
    _welcomeAnimController.forward();

    // Skip button fade-in after 2.5s
    _skipFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _skipFadeAnim = CurvedAnimation(
      parent: _skipFadeController,
      curve: Curves.easeIn,
    );
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) _skipFadeController.forward();
    });
  }

  void _next() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _complete();
    }
  }

  void _complete() async {
    await context.read<AppState>().completeOnboarding();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ShellScreen()),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _welcomeAnimController.dispose();
    _skipFadeController.dispose();
    super.dispose();
  }

  String _buttonText() {
    if (_currentPage == 0) return 'Get Started';
    if (_currentPage == _totalPages - 1) return 'Get Started';
    return 'Next';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button — hidden initially, fades in after 2.5s
            Align(
              alignment: Alignment.topRight,
              child: AnimatedBuilder(
                animation: _skipFadeAnim,
                builder: (context, child) {
                  return IgnorePointer(
                    ignoring: _skipFadeAnim.value < 0.1,
                    child: Opacity(
                      opacity: _skipFadeAnim.value,
                      child: child,
                    ),
                  );
                },
                child: TextButton(
                  onPressed: _complete,
                  child: Text(
                    'Skip',
                    style: TextStyle(color: theme.textTheme.bodySmall?.color),
                  ),
                ),
              ),
            ),
            // Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (page) =>
                    setState(() => _currentPage = page),
                itemCount: _totalPages,
                itemBuilder: (context, index) {
                  if (index == 0) return _buildWelcomePage(theme);
                  final page = _contentPages[index - 1];
                  return _buildContentPage(theme, page);
                },
              ),
            ),
            // Dot indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_totalPages, (i) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == i ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? AppColors.primaryPurple
                        : AppColors.primaryPurple.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            // Next / Get Started button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: _next,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    _buttonText(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomePage(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: _welcomeFadeAnim,
            child: ScaleTransition(
              scale: _welcomeScaleAnim,
              child: SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      child: Icon(Icons.auto_awesome, size: 36,
                          color: AppColors.primaryPurple.withValues(alpha: 0.8)),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Icon(Icons.star, size: 32,
                          color: AppColors.primaryPurple.withValues(alpha: 0.6)),
                    ),
                    Positioned(
                      left: 0,
                      child: Icon(Icons.wb_sunny_outlined, size: 30,
                          color: AppColors.primaryPurple.withValues(alpha: 0.7)),
                    ),
                    Icon(Icons.calendar_month, size: 48,
                        color: AppColors.primaryPurple),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'What if every month\nwas perfect?',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Discover a calendar where every month has '
            'exactly 28 days — simple, balanced, and harmonious.',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContentPage(ThemeData theme, _OnboardingPageData page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              page.icon,
              size: 64,
              color: AppColors.primaryPurple,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            page.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            page.body,
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _OnboardingPageData {
  final IconData icon;
  final String title;
  final String body;

  const _OnboardingPageData({
    required this.icon,
    required this.title,
    required this.body,
  });
}
