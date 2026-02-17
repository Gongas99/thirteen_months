# 13 Months

A cross-platform Flutter app that brings the **International Fixed Calendar (IFC)** to life. Browse 13 perfectly equal months, convert dates between calendars, and keep the IFC date on your home screen with native widgets. Based on the original project at [13months.net](https://www.13months.net/).

## What is the International Fixed Calendar?

The IFC is a calendar reform proposed by Moses Cotsworth in 1902. It restructures the year into **13 months of exactly 28 days**, so every month has 4 complete weeks and every date falls on the same weekday, every year.

| Concept | Detail |
|---|---|
| Months | 13 months x 28 days = 364 days |
| 13th month | **Sol**, placed between June and July |
| Year Day | An extra day (Dec 29 in Gregorian) that sits outside any month or week |
| Leap Day | In leap years, an extra day between June and Sol, also outside the week |
| First day | Every year and every month starts on **Sunday** |

The calendar was famously adopted by **Eastman Kodak** from 1928 to 1989 for internal accounting.

## Features

### Today
- Live clock with hours, minutes, and seconds
- Current date in both IFC and Gregorian formats
- Special day indicators for Year Day and Leap Day
- Rotating fun facts about the calendar
- Settings for widget transparency and language

### Calendar
- Full 13-month overview in a compact grid
- Current month and day highlighting
- Tap any month for a detailed view with day-by-day info
- Year navigation to browse any year
- Special days card and day count summary

### Converter
- Bidirectional conversion between Gregorian and IFC
- Native date picker for Gregorian input
- Month/day selectors for IFC input with special day support
- Handles Year Day, Leap Day, and leap year validation

### Learn
- Quick facts about the IFC structure
- Visual 28-day month grid
- Historical timeline from 1902 to today
- FAQ section covering common questions

### Home Screen Widgets

Native widgets for both platforms, with transparent and opaque styles.

**iOS** (WidgetKit) &mdash; small, medium, and large sizes:
- Clock with IFC and Gregorian date labels
- Minute-level updates
- Transparent or frosted material background

**Android** (AppWidgetProvider) &mdash; 5 responsive layouts:
- Date only, small, medium, large, and wide variants
- Resizable with automatic layout switching
- System-aware 12/24h time format

### Additional
- **Onboarding** &mdash; 5-page animated introduction for new users
- **Dark mode** &mdash; full light and dark theme support following system preference
- **Localization** &mdash; English, Portuguese, Spanish, French, German, and Italian
- **Birthday prompt** &mdash; discover what your birthday looks like in the IFC

## Tech Stack

| Layer | Choice |
|---|---|
| Framework | Flutter (Dart SDK ^3.11.0) |
| State management | Provider |
| Persistence | SharedPreferences |
| Typography | DM Sans via Google Fonts |
| Widget bridge | home_widget |
| iOS widgets | SwiftUI + WidgetKit |
| Android widgets | RemoteViews + AppWidgetProvider |
| Design system | Material 3 |

## Project Structure

```
lib/
├── main.dart                         # Entry point, HomeWidget init
├── app.dart                          # MaterialApp, theme, locale
├── core/
│   ├── ifc_date.dart                 # IFC <-> Gregorian conversion
│   ├── ifc_constants.dart            # Timeline, FAQ, fun facts
│   └── theme.dart                    # Colors, light/dark themes
├── screens/
│   ├── shell_screen.dart             # Bottom navigation + tabs
│   ├── today/today_screen.dart
│   ├── calendar/
│   │   ├── calendar_screen.dart      # 13-month grid overview
│   │   └── month_detail_screen.dart  # Single month detail + swipe
│   ├── converter/converter_screen.dart
│   └── learn/learn_screen.dart
├── widgets/                          # Reusable UI components
├── state/app_state.dart              # App-wide state (Provider)
├── l10n/                             # Localization (ARB + generated)
└── onboarding/onboarding_screen.dart

ios/IfcWidget/                        # iOS widget extension (Swift)
android/.../IfcWidgetProvider.kt      # Android widget provider
android/.../res/layout/               # Android widget XML layouts
```

## Getting Started

### Prerequisites

- Flutter SDK 3.11+
- Xcode (for iOS)
- Android Studio or Android SDK (for Android)

### Run

```bash
cd thirteen_months
flutter pub get
flutter run
```

### Build

```bash
# Android
flutter build apk

# iOS
flutter build ios
```

## References

- [13months.net](https://www.13months.net/) — the original website for the 13 Months project

## License

This project is not published to pub.dev and is maintained as a private application.
