import WidgetKit
import SwiftUI

private let appGroupId = "group.com.thirteenmonths.thirteenMonths"

struct IfcEntry: TimelineEntry {
    let date: Date
    let ifcDateText: String
    let gregorianDateText: String
    let isTransparent: Bool
}

struct IfcTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> IfcEntry {
        IfcEntry(date: Date(), ifcDateText: "IFC Date", gregorianDateText: "Gregorian Date", isTransparent: true)
    }

    func getSnapshot(in context: Context, completion: @escaping (IfcEntry) -> Void) {
        completion(readEntry(date: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<IfcEntry>) -> Void) {
        let now = Date()
        let calendar = Calendar.current

        // Start of the current minute
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: now)
        guard let startOfMinute = calendar.date(from: components) else {
            let entry = readEntry(date: now)
            completion(Timeline(entries: [entry], policy: .after(now.addingTimeInterval(60))))
            return
        }

        // Generate 60 entries (one per minute for the next hour)
        var entries: [IfcEntry] = []
        for minuteOffset in 0..<60 {
            guard let entryDate = calendar.date(byAdding: .minute, value: minuteOffset, to: startOfMinute) else { continue }
            entries.append(readEntry(date: entryDate))
        }

        // Refresh after the last entry
        let refreshDate = calendar.date(byAdding: .minute, value: 60, to: startOfMinute) ?? now.addingTimeInterval(3600)
        completion(Timeline(entries: entries, policy: .after(refreshDate)))
    }

    private func readEntry(date: Date) -> IfcEntry {
        let defaults = UserDefaults(suiteName: appGroupId)
        let ifcText = defaults?.string(forKey: "ifc_date_text") ?? "IFC Date"
        let gregText = defaults?.string(forKey: "gregorian_date_text") ?? ""
        let isTransparent = defaults?.object(forKey: "widget_transparent") as? Bool ?? true
        return IfcEntry(date: date, ifcDateText: ifcText, gregorianDateText: gregText, isTransparent: isTransparent)
    }
}

@main
struct IfcWidget: Widget {
    let kind: String = "IfcWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: IfcTimelineProvider()) { entry in
            IfcWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("IFC Calendar")
        .description("Shows the current IFC date and time.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
