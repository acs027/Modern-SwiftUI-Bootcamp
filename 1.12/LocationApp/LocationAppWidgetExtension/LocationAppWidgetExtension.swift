//
//  LocationAppWidgetExtension.swift
//  LocationAppWidgetExtension
//
//  Created by ali cihan on 7.10.2025.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct LocationAppWidgetExtensionEntryView : View {
    @Query private var favoriteLocations: [FavoriteLocation]

    var body: some View {
        VStack {
            if let location = favoriteLocations.last {
                Text("Favorite Location: ")
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                Text(location.name)
            } else {
                Text("Favorite Locations")
            }

        }
    }
}

struct LocationAppWidgetExtension: Widget {
    let kind: String = "LocationAppWidgetExtension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                LocationAppWidgetExtensionEntryView()
                    .modelContainer(for: FavoriteLocation.self)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                LocationAppWidgetExtensionEntryView()
                    .modelContainer(for: FavoriteLocation.self)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Favorite Location")
        .description("Favorite Location Widget.")
    }
}

#Preview(as: .systemSmall) {
    LocationAppWidgetExtension()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
