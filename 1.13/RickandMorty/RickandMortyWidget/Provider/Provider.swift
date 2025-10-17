//
//  Provider.swift
//  RickandMorty
//
//  Created by ali cihan on 17.10.2025.
//

import WidgetKit
import Foundation


struct Provider: TimelineProvider {
    typealias Entry = RMCharacterEntry
    let apiService = WidgetAPIService()
    
    func placeholder(in context: Context) -> RMCharacterEntry {
        RMCharacterEntry(date: .now, name: "Rick", image: "")
    }
    
    func getSnapshot(in context: Context, completion: @escaping @Sendable (RMCharacterEntry) -> Void) {
        if context.isPreview {
            completion(RMCharacterEntry(date: .now, name: "Snapshot", image: ""))
            return
        }
        
        Task {
            let entry = await fetchCharacter(id: 2)
            completion(entry)
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<RMCharacterEntry>) -> Void) {
        Task {
            let currentDate = Date()
            var entries: [RMCharacterEntry] = []
            
            var entry = await fetchCharacter(id: 2)
            entries.append(entry)
            
//            for hourOffset in 0..<5 {
//                let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset * 15, to: currentDate)!
//                let entry = RMCharacterEntry(date: .now, name: "Rick", image: "")
//                entries.append(entry)
//                print("Entry added")
//            }
            
            for minuteOffset in 0..<60 {
                    let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
                entry.date = entryDate
                    entries.append(entry)
                }
            
            let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
            print("Next update will be at \(currentDate.formatted(date: .omitted, time: .standard))")
            print("Timeline created")
            
            let timeline = Timeline(entries: entries, policy: .after(nextUpdate))
            completion(timeline)
        }
    }
    
    func fetchCharacter(id: Int) async -> RMCharacterEntry {
        do {
            let response = try await apiService.fetchCharacter(by: id)
            let imageData = await apiService.fetchImageData(url: URL(string: response.image))
            let entry = RMCharacterEntry(date: .now, name: response.name, image: response.image, imageData: imageData)
            print(entry)
            return entry
        } catch {
            print(error.localizedDescription)
            return RMCharacterEntry(date: .now, name: "Unknown", image: "Unknown")
        }
    }
}
