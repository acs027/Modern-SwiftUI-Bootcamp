//
//  LocationAppWidgetExtension.swift
//  LocationAppWidgetExtension
//
//  Created by ali cihan on 7.10.2025.
//

import WidgetKit
import SwiftUI
import SwiftData

struct LocationAppWidgetExtensionEntryView : View {
    var entry: Provider.Entry
    @Query private var favoriteLocations: [FavoriteLocation]
    
    
    var body: some View {
        VStack {
            Image(systemName: "star.fill")
                .foregroundColor(.brown)
                .minimumScaleFactor(0.7)
            Text("Location: ")
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            if let location = favoriteLocations.last {
                Text(location.name)
                    .minimumScaleFactor(0.7)
            } else {
                Text(entry.location.name)
            }
        }
    }
}

struct LocationAppWidgetExtension: Widget {
    let kind: String = "LocationAppWidgetExtension"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LocationAppWidgetExtensionEntryView(entry: entry)
                .modelContainer(for: FavoriteLocation.self)
                .padding()
                .containerBackground(for: .widget) {
                    Color(.systemBackground)
                }
        }
        .configurationDisplayName("Favorite Location")
        .description("Favorite Location Widget.")
    }
}

#Preview(as: .systemSmall) {
    LocationAppWidgetExtension()
} timeline: {
    LocationEntry(date: .now, location: .mock)
}
