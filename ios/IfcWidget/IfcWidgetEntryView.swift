import SwiftUI
import WidgetKit

struct IfcWidgetEntryView: View {
    var entry: IfcEntry

    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            smallView
        case .systemMedium:
            mediumView
        case .systemLarge:
            largeView
        default:
            smallView
        }
    }

    // MARK: - Small: Clock + IFC date

    private var primaryTextColor: Color {
        entry.isTransparent ? .white : Color(UIColor.label)
    }

    private var secondaryTextColor: Color {
        entry.isTransparent ? .white.opacity(0.7) : Color(UIColor.secondaryLabel)
    }

    private var tertiaryTextColor: Color {
        entry.isTransparent ? .white.opacity(0.5) : Color(UIColor.tertiaryLabel)
    }

    private var smallView: some View {
        VStack(spacing: 2) {
            Text(entry.date, style: .time)
                .font(.system(size: 40, weight: .bold, design: .default))
                .foregroundColor(primaryTextColor)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                .minimumScaleFactor(0.6)

            Text(entry.ifcDateText.uppercased())
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(secondaryTextColor)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .widgetBackground(isTransparent: entry.isTransparent)
    }

    // MARK: - Medium: Clock + IFC date + Gregorian date (horizontal)

    private var mediumView: some View {
        VStack(spacing: 4) {
            HStack(spacing: 6) {
                Text("IFC")
                    .font(.system(size: 10, weight: .medium))
                    .tracking(1.5)
                    .foregroundColor(tertiaryTextColor)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)

                Text(entry.ifcDateText.uppercased())
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(secondaryTextColor)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                    .lineLimit(1)
            }

            Text(entry.date, style: .time)
                .font(.system(size: 52, weight: .bold, design: .default))
                .foregroundColor(primaryTextColor)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                .minimumScaleFactor(0.5)

            if !entry.gregorianDateText.isEmpty {
                HStack(spacing: 6) {
                    Text("GRE")
                        .font(.system(size: 10, weight: .medium))
                        .tracking(1.5)
                        .foregroundColor(tertiaryTextColor)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)

                    Text(entry.gregorianDateText.uppercased())
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(secondaryTextColor)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                        .lineLimit(1)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .widgetBackground(isTransparent: entry.isTransparent)
    }

    // MARK: - Large: Clock + labeled IFC & Gregorian dates

    private var largeView: some View {
        VStack(spacing: 8) {
            Text(entry.date, style: .time)
                .font(.system(size: 72, weight: .bold, design: .default))
                .foregroundColor(primaryTextColor)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                .minimumScaleFactor(0.5)

            // IFC date row
            HStack(spacing: 8) {
                Text("IFC")
                    .font(.system(size: 12, weight: .medium))
                    .tracking(1.5)
                    .foregroundColor(tertiaryTextColor)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)

                Text(entry.ifcDateText.uppercased())
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(primaryTextColor)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
            }

            // Gregorian date row
            if !entry.gregorianDateText.isEmpty {
                HStack(spacing: 8) {
                    Text("GRE")
                        .font(.system(size: 12, weight: .medium))
                        .tracking(1.5)
                        .foregroundColor(tertiaryTextColor)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)

                    Text(entry.gregorianDateText.uppercased())
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(secondaryTextColor)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .widgetBackground(isTransparent: entry.isTransparent)
    }
}
