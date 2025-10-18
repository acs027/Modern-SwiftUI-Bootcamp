//
//  Provider.swift
//  RickandMorty
//
//  Created by ali cihan on 17.10.2025.
//

import WidgetKit
import Foundation
import SwiftData

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
            let calendar = Calendar.current
            var entries: [RMCharacterEntry] = []
            let charID = await fetchFavoriteOrRandomCharacter()
            var entry = await fetchCharacter(id: charID)
            print(charID)
            
            let currentHourStart = calendar.dateComponents([.year, .month, .day, .hour], from: currentDate)
            let startOfCurrentHour = calendar.date(from: currentHourStart)!
            //            let nextFullHour = Calendar.current.nextDate(
            //                        after: currentDate,
            //                        matching: DateComponents(minute: 0, second: 0),
            //                        matchingPolicy: .nextTime)!
            let minutesUntilNextHour = 60 - calendar.component(.minute, from: currentDate)
            
            for minuteOffset in 0..<minutesUntilNextHour {
                let entryDate = calendar.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
                entry.date = entryDate
                entries.append(entry)
                print(entry.date, entry.name)
            }
            
            let nextUpdate = calendar.date(byAdding: .hour, value: 1, to: startOfCurrentHour)!
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
    
    // MARK: - Helper: read SwiftData
    func fetchFavoriteOrRandomCharacter() async -> Int {
        do {
            let container = try ModelContainer(for: FavoriteCharacter.self)
            let context = ModelContext(container)
            let descriptor = FetchDescriptor<FavoriteCharacter>()
            let favorites = try context.fetch(descriptor)
            if let favorite = favorites.randomElement() {
                return favorite.id
            } else {
                return 1
            }
        } catch {
            print("⚠️ Failed to read SwiftData: \(error)")
            return 1
        }
    }
}
