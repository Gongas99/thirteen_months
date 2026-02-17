import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pt'),
  ];

  /// No description provided for @tabToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get tabToday;

  /// No description provided for @tabCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get tabCalendar;

  /// No description provided for @tabConverter.
  ///
  /// In en, this message translates to:
  /// **'Converter'**
  String get tabConverter;

  /// No description provided for @tabLearn.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get tabLearn;

  /// No description provided for @label13MonthCalendar.
  ///
  /// In en, this message translates to:
  /// **'13-Month Calendar'**
  String get label13MonthCalendar;

  /// No description provided for @yearDay.
  ///
  /// In en, this message translates to:
  /// **'Year Day'**
  String get yearDay;

  /// No description provided for @leapDay.
  ///
  /// In en, this message translates to:
  /// **'Leap Day'**
  String get leapDay;

  /// No description provided for @todayInIfc.
  ///
  /// In en, this message translates to:
  /// **'Today in IFC'**
  String get todayInIfc;

  /// No description provided for @todayIsAlso.
  ///
  /// In en, this message translates to:
  /// **'In the Gregorian calendar'**
  String get todayIsAlso;

  /// No description provided for @labelGregorian.
  ///
  /// In en, this message translates to:
  /// **'Gregorian'**
  String get labelGregorian;

  /// No description provided for @birthdayPromptTitle.
  ///
  /// In en, this message translates to:
  /// **'When is your birthday?'**
  String get birthdayPromptTitle;

  /// No description provided for @birthdayPromptSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find out your birthday in the 13-month calendar'**
  String get birthdayPromptSubtitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsWidget.
  ///
  /// In en, this message translates to:
  /// **'Widget'**
  String get settingsWidget;

  /// No description provided for @settingsTransparentBg.
  ///
  /// In en, this message translates to:
  /// **'Transparent background'**
  String get settingsTransparentBg;

  /// No description provided for @settingsTransparentBgDesc.
  ///
  /// In en, this message translates to:
  /// **'Widget floats over your wallpaper'**
  String get settingsTransparentBgDesc;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystem;

  /// No description provided for @languageEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEn;

  /// No description provided for @languagePt.
  ///
  /// In en, this message translates to:
  /// **'Português'**
  String get languagePt;

  /// No description provided for @languageEs.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get languageEs;

  /// No description provided for @languageFr.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get languageFr;

  /// No description provided for @languageDe.
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get languageDe;

  /// No description provided for @languageIt.
  ///
  /// In en, this message translates to:
  /// **'Italiano'**
  String get languageIt;

  /// No description provided for @monthJanuary.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get monthJanuary;

  /// No description provided for @monthFebruary.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get monthFebruary;

  /// No description provided for @monthMarch.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get monthMarch;

  /// No description provided for @monthApril.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get monthApril;

  /// No description provided for @monthMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get monthMay;

  /// No description provided for @monthJune.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get monthJune;

  /// No description provided for @monthSol.
  ///
  /// In en, this message translates to:
  /// **'Sol'**
  String get monthSol;

  /// No description provided for @monthJuly.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get monthJuly;

  /// No description provided for @monthAugust.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get monthAugust;

  /// No description provided for @monthSeptember.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get monthSeptember;

  /// No description provided for @monthOctober.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get monthOctober;

  /// No description provided for @monthNovember.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get monthNovember;

  /// No description provided for @monthDecember.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get monthDecember;

  /// No description provided for @weekdaySunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get weekdaySunday;

  /// No description provided for @weekdayMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get weekdayMonday;

  /// No description provided for @weekdayTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get weekdayTuesday;

  /// No description provided for @weekdayWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get weekdayWednesday;

  /// No description provided for @weekdayThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get weekdayThursday;

  /// No description provided for @weekdayFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get weekdayFriday;

  /// No description provided for @weekdaySaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get weekdaySaturday;

  /// No description provided for @weekdayAbbrSun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get weekdayAbbrSun;

  /// No description provided for @weekdayAbbrMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get weekdayAbbrMon;

  /// No description provided for @weekdayAbbrTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get weekdayAbbrTue;

  /// No description provided for @weekdayAbbrWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get weekdayAbbrWed;

  /// No description provided for @weekdayAbbrThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get weekdayAbbrThu;

  /// No description provided for @weekdayAbbrFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get weekdayAbbrFri;

  /// No description provided for @weekdayAbbrSat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get weekdayAbbrSat;

  /// No description provided for @gregWeekdayMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get gregWeekdayMonday;

  /// No description provided for @gregWeekdayTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get gregWeekdayTuesday;

  /// No description provided for @gregWeekdayWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get gregWeekdayWednesday;

  /// No description provided for @gregWeekdayThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get gregWeekdayThursday;

  /// No description provided for @gregWeekdayFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get gregWeekdayFriday;

  /// No description provided for @gregWeekdaySaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get gregWeekdaySaturday;

  /// No description provided for @gregWeekdaySunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get gregWeekdaySunday;

  /// No description provided for @gregMonthJanuary.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get gregMonthJanuary;

  /// No description provided for @gregMonthFebruary.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get gregMonthFebruary;

  /// No description provided for @gregMonthMarch.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get gregMonthMarch;

  /// No description provided for @gregMonthApril.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get gregMonthApril;

  /// No description provided for @gregMonthMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get gregMonthMay;

  /// No description provided for @gregMonthJune.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get gregMonthJune;

  /// No description provided for @gregMonthJuly.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get gregMonthJuly;

  /// No description provided for @gregMonthAugust.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get gregMonthAugust;

  /// No description provided for @gregMonthSeptember.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get gregMonthSeptember;

  /// No description provided for @gregMonthOctober.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get gregMonthOctober;

  /// No description provided for @gregMonthNovember.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get gregMonthNovember;

  /// No description provided for @gregMonthDecember.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get gregMonthDecember;

  /// No description provided for @specialDays.
  ///
  /// In en, this message translates to:
  /// **'Special Days'**
  String get specialDays;

  /// No description provided for @yearDayDesc.
  ///
  /// In en, this message translates to:
  /// **'After December 28 — outside any month or week'**
  String get yearDayDesc;

  /// No description provided for @leapDayDesc.
  ///
  /// In en, this message translates to:
  /// **'Between June 28 and Sol 1 — outside the week'**
  String get leapDayDesc;

  /// No description provided for @calendarFunFact.
  ///
  /// In en, this message translates to:
  /// **'The 13th month, Sol, is named after the Latin word for Sun.'**
  String get calendarFunFact;

  /// No description provided for @plusYearDay.
  ///
  /// In en, this message translates to:
  /// **'+ Year Day'**
  String get plusYearDay;

  /// No description provided for @plusLeapDay.
  ///
  /// In en, this message translates to:
  /// **'+ Leap Day'**
  String get plusLeapDay;

  /// No description provided for @daysLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String daysLabel(int count);

  /// No description provided for @monthXOfY.
  ///
  /// In en, this message translates to:
  /// **'Month {month} of 13'**
  String monthXOfY(int month);

  /// No description provided for @swipeToNavigate.
  ///
  /// In en, this message translates to:
  /// **'Swipe to navigate between months'**
  String get swipeToNavigate;

  /// No description provided for @gregorianColon.
  ///
  /// In en, this message translates to:
  /// **'Gregorian:'**
  String get gregorianColon;

  /// No description provided for @weekOfMonthColon.
  ///
  /// In en, this message translates to:
  /// **'Week of month:'**
  String get weekOfMonthColon;

  /// No description provided for @xOfY.
  ///
  /// In en, this message translates to:
  /// **'{x} of {y}'**
  String xOfY(int x, int y);

  /// No description provided for @gregorianRange.
  ///
  /// In en, this message translates to:
  /// **'Gregorian range'**
  String get gregorianRange;

  /// No description provided for @labelDays.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get labelDays;

  /// No description provided for @labelWeeks.
  ///
  /// In en, this message translates to:
  /// **'Weeks'**
  String get labelWeeks;

  /// No description provided for @gregorianToIfc.
  ///
  /// In en, this message translates to:
  /// **'Gregorian → IFC'**
  String get gregorianToIfc;

  /// No description provided for @ifcToGregorian.
  ///
  /// In en, this message translates to:
  /// **'IFC → Gregorian'**
  String get ifcToGregorian;

  /// No description provided for @gregorianDate.
  ///
  /// In en, this message translates to:
  /// **'Gregorian Date'**
  String get gregorianDate;

  /// No description provided for @ifcDate.
  ///
  /// In en, this message translates to:
  /// **'IFC Date'**
  String get ifcDate;

  /// No description provided for @monthXOfYWeekXOfY.
  ///
  /// In en, this message translates to:
  /// **'Month {month} of 13  •  Week {week} of 4'**
  String monthXOfYWeekXOfY(int month, int week);

  /// No description provided for @yearDaySpecialDesc.
  ///
  /// In en, this message translates to:
  /// **'Outside any month — a universal holiday'**
  String get yearDaySpecialDesc;

  /// No description provided for @leapDaySpecialDesc.
  ///
  /// In en, this message translates to:
  /// **'Between June and Sol — outside the week'**
  String get leapDaySpecialDesc;

  /// No description provided for @labelYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get labelYear;

  /// No description provided for @labelType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get labelType;

  /// No description provided for @regularDay.
  ///
  /// In en, this message translates to:
  /// **'Regular day'**
  String get regularDay;

  /// No description provided for @labelMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get labelMonth;

  /// No description provided for @labelDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get labelDay;

  /// No description provided for @converterFunFact.
  ///
  /// In en, this message translates to:
  /// **'Fun fact: In the IFC, your birthday always falls on the same day of the week, every single year.'**
  String get converterFunFact;

  /// No description provided for @yourCalendar.
  ///
  /// In en, this message translates to:
  /// **'Your calendar'**
  String get yourCalendar;

  /// No description provided for @dayOutsideCalendar.
  ///
  /// In en, this message translates to:
  /// **'A day outside the calendar — a universal holiday'**
  String get dayOutsideCalendar;

  /// No description provided for @extraDayBetween.
  ///
  /// In en, this message translates to:
  /// **'An extra day between June and Sol'**
  String get extraDayBetween;

  /// No description provided for @daysEveryMonth.
  ///
  /// In en, this message translates to:
  /// **'28 days every month'**
  String get daysEveryMonth;

  /// No description provided for @learnHeader.
  ///
  /// In en, this message translates to:
  /// **'The whole idea\nin 30 seconds'**
  String get learnHeader;

  /// No description provided for @everyMonthLooksLikeThis.
  ///
  /// In en, this message translates to:
  /// **'Every month looks like this'**
  String get everyMonthLooksLikeThis;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// No description provided for @faqTitle.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faqTitle;

  /// No description provided for @quickFact1.
  ///
  /// In en, this message translates to:
  /// **'Every month has exactly 28 days — 4 perfect weeks.'**
  String get quickFact1;

  /// No description provided for @quickFact2.
  ///
  /// In en, this message translates to:
  /// **'There are 13 months: the extra month is called Sol, between June and July.'**
  String get quickFact2;

  /// No description provided for @quickFact3.
  ///
  /// In en, this message translates to:
  /// **'Year Day (December 29) sits outside any month or week — a universal holiday.'**
  String get quickFact3;

  /// No description provided for @quickFact4.
  ///
  /// In en, this message translates to:
  /// **'In leap years, Leap Day falls between June and Sol — also outside the week.'**
  String get quickFact4;

  /// No description provided for @timelineYear1.
  ///
  /// In en, this message translates to:
  /// **'1902'**
  String get timelineYear1;

  /// No description provided for @timelineTitle1.
  ///
  /// In en, this message translates to:
  /// **'Moses Cotsworth proposes the IFC'**
  String get timelineTitle1;

  /// No description provided for @timelineDesc1.
  ///
  /// In en, this message translates to:
  /// **'British accountant Moses B. Cotsworth publishes \"The Rational Almanac\", proposing a 13-month calendar for simpler business accounting.'**
  String get timelineDesc1;

  /// No description provided for @timelineYear2.
  ///
  /// In en, this message translates to:
  /// **'1922'**
  String get timelineYear2;

  /// No description provided for @timelineTitle2.
  ///
  /// In en, this message translates to:
  /// **'League of Nations considers calendar reform'**
  String get timelineTitle2;

  /// No description provided for @timelineDesc2.
  ///
  /// In en, this message translates to:
  /// **'The League of Nations establishes a committee to study calendar reform, with the IFC as a leading candidate.'**
  String get timelineDesc2;

  /// No description provided for @timelineYear3.
  ///
  /// In en, this message translates to:
  /// **'1928'**
  String get timelineYear3;

  /// No description provided for @timelineTitle3.
  ///
  /// In en, this message translates to:
  /// **'George Eastman adopts the IFC'**
  String get timelineTitle3;

  /// No description provided for @timelineDesc3.
  ///
  /// In en, this message translates to:
  /// **'Kodak founder George Eastman adopts the IFC for Kodak\'s internal accounting. The company uses it until 1989.'**
  String get timelineDesc3;

  /// No description provided for @timelineYear4.
  ///
  /// In en, this message translates to:
  /// **'1937'**
  String get timelineYear4;

  /// No description provided for @timelineTitle4.
  ///
  /// In en, this message translates to:
  /// **'UN vote falls short'**
  String get timelineTitle4;

  /// No description provided for @timelineDesc4.
  ///
  /// In en, this message translates to:
  /// **'The League of Nations vote on the IFC fails to achieve unanimous approval, largely due to religious objections about breaking the 7-day Sabbath cycle.'**
  String get timelineDesc4;

  /// No description provided for @timelineYear5.
  ///
  /// In en, this message translates to:
  /// **'1989'**
  String get timelineYear5;

  /// No description provided for @timelineTitle5.
  ///
  /// In en, this message translates to:
  /// **'Kodak discontinues IFC use'**
  String get timelineTitle5;

  /// No description provided for @timelineDesc5.
  ///
  /// In en, this message translates to:
  /// **'After over 60 years, Kodak stops using the International Fixed Calendar for internal operations.'**
  String get timelineDesc5;

  /// No description provided for @timelineYear6.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get timelineYear6;

  /// No description provided for @timelineTitle6.
  ///
  /// In en, this message translates to:
  /// **'Growing interest online'**
  String get timelineTitle6;

  /// No description provided for @timelineDesc6.
  ///
  /// In en, this message translates to:
  /// **'The IFC has found new popularity through social media and websites like 13months.net, with advocates highlighting its simplicity.'**
  String get timelineDesc6;

  /// No description provided for @faq1Question.
  ///
  /// In en, this message translates to:
  /// **'Why 13 months?'**
  String get faq1Question;

  /// No description provided for @faq1Answer.
  ///
  /// In en, this message translates to:
  /// **'13 × 28 = 364 days, just one short of a regular year. Each month has exactly 4 weeks, making scheduling, billing, and planning perfectly regular. The remaining day becomes Year Day, a special holiday.'**
  String get faq1Answer;

  /// No description provided for @faq2Question.
  ///
  /// In en, this message translates to:
  /// **'What is Sol?'**
  String get faq2Question;

  /// No description provided for @faq2Answer.
  ///
  /// In en, this message translates to:
  /// **'Sol is the 7th month, inserted between June and July. It\'s named after the Sun (Latin \"sol\"). In the IFC, the months after June shift: Sol, July, August, September, October, November, December.'**
  String get faq2Answer;

  /// No description provided for @faq3Question.
  ///
  /// In en, this message translates to:
  /// **'What is Year Day?'**
  String get faq3Question;

  /// No description provided for @faq3Answer.
  ///
  /// In en, this message translates to:
  /// **'Year Day falls after December 28 (the last regular day) and before January 1 of the next year. It belongs to no month and no weekday — it\'s a universal day off, ensuring every year starts on Sunday.'**
  String get faq3Answer;

  /// No description provided for @faq4Question.
  ///
  /// In en, this message translates to:
  /// **'How do leap years work?'**
  String get faq4Question;

  /// No description provided for @faq4Answer.
  ///
  /// In en, this message translates to:
  /// **'Leap years follow the same rules as the Gregorian calendar (every 4 years, except centuries not divisible by 400). The extra day, Leap Day, is inserted between June 28 and Sol 1. Like Year Day, it has no weekday.'**
  String get faq4Answer;

  /// No description provided for @faq5Question.
  ///
  /// In en, this message translates to:
  /// **'What day of the week is my birthday?'**
  String get faq5Question;

  /// No description provided for @faq5Answer.
  ///
  /// In en, this message translates to:
  /// **'In the IFC, every date falls on the same weekday every year! If your IFC birthday is the 15th, it\'s always a Sunday. Use the Converter tab to find your IFC birthday.'**
  String get faq5Answer;

  /// No description provided for @faq6Question.
  ///
  /// In en, this message translates to:
  /// **'Could this calendar actually be adopted?'**
  String get faq6Question;

  /// No description provided for @faq6Answer.
  ///
  /// In en, this message translates to:
  /// **'The biggest obstacle is tradition and the disruption of the continuous 7-day Sabbath cycle. Year Day and Leap Day break the weekly pattern, which some religious traditions consider unacceptable. Despite this, the IFC remains one of the most practical calendar reform proposals.'**
  String get faq6Answer;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'What if every month\nwas perfect?'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Discover a calendar where every month has exactly 28 days — simple, balanced, and harmonious.'**
  String get onboardingWelcomeBody;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'13 Perfect Months'**
  String get onboardingTitle1;

  /// No description provided for @onboardingBody1.
  ///
  /// In en, this message translates to:
  /// **'Every month has exactly 28 days — 4 perfect weeks. No more wondering what day the 15th falls on.'**
  String get onboardingBody1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Meet Sol'**
  String get onboardingTitle2;

  /// No description provided for @onboardingBody2.
  ///
  /// In en, this message translates to:
  /// **'The 7th month, Sol, sits between June and July. Named after the Sun, it completes the 13-month year.'**
  String get onboardingBody2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Year Day & Leap Day'**
  String get onboardingTitle3;

  /// No description provided for @onboardingBody3.
  ///
  /// In en, this message translates to:
  /// **'Year Day (after Dec 28) belongs to no month or week — a universal holiday. Leap Day works the same way, falling between June and Sol.'**
  String get onboardingBody3;

  /// No description provided for @onboardingTitle4.
  ///
  /// In en, this message translates to:
  /// **'Explore the Calendar'**
  String get onboardingTitle4;

  /// No description provided for @onboardingBody4.
  ///
  /// In en, this message translates to:
  /// **'See today\'s IFC date, browse all 13 months, convert dates, and learn the history. Let\'s get started!'**
  String get onboardingBody4;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @funFact1.
  ///
  /// In en, this message translates to:
  /// **'In the IFC, every month starts on Sunday and ends on Saturday.'**
  String get funFact1;

  /// No description provided for @funFact2.
  ///
  /// In en, this message translates to:
  /// **'Friday the 13th occurs every month in the IFC!'**
  String get funFact2;

  /// No description provided for @funFact3.
  ///
  /// In en, this message translates to:
  /// **'Your IFC birthday is always on the same weekday, every year.'**
  String get funFact3;

  /// No description provided for @funFact4.
  ///
  /// In en, this message translates to:
  /// **'Kodak used the IFC internally for over 60 years (1928–1989).'**
  String get funFact4;

  /// No description provided for @funFact5.
  ///
  /// In en, this message translates to:
  /// **'The 13th month, Sol, is named after the Latin word for Sun.'**
  String get funFact5;

  /// No description provided for @funFact6.
  ///
  /// In en, this message translates to:
  /// **'13 × 28 = 364. Add Year Day (and Leap Day) to complete the year.'**
  String get funFact6;

  /// No description provided for @funFact7.
  ///
  /// In en, this message translates to:
  /// **'George Eastman was the IFC\'s biggest corporate champion.'**
  String get funFact7;

  /// No description provided for @funFact8.
  ///
  /// In en, this message translates to:
  /// **'Every IFC quarter has exactly 91 days (13 weeks).'**
  String get funFact8;

  /// No description provided for @funFactLabel.
  ///
  /// In en, this message translates to:
  /// **'Did you know?'**
  String get funFactLabel;

  /// No description provided for @tapForNewFact.
  ///
  /// In en, this message translates to:
  /// **'Tap for another fact'**
  String get tapForNewFact;

  /// No description provided for @visitWebsite.
  ///
  /// In en, this message translates to:
  /// **'Visit Website'**
  String get visitWebsite;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
