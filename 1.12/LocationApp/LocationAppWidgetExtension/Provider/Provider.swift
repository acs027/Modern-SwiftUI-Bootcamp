//
//  Provider.swift
//  LocationApp
//
//  Created by ali cihan on 14.10.2025.
//

import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> LocationEntry {
        LocationEntry(date: .now, location: .mock)
    }

    func getSnapshot(in context: Context, completion: @escaping (LocationEntry) -> ()) {
        completion(LocationEntry(date: .now, location: .mock))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        var entries: [LocationEntry] = []
        
        for hourOffset in 0..<5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset * 15, to: currentDate)!
            let entry = LocationEntry(date: entryDate, location: .mock)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
