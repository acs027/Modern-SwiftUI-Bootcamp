//
//  EventViewModel.swift
//  Events
//
//  Created by ali cihan on 10.09.2025.
//

import Foundation
import Observation

@Observable
final class EventViewModel {
    var events: [Event] = []
    
    
    func addEvent(event: Event) {
        self.events.append(event)
    }
    
    func loadMockData() {
        let events = [
            Event(title: "Birthday", date: Date().addingTimeInterval(3000000), type: .birthday, hasReminder: true),
            Event(title: "Holiday", date: Date().addingTimeInterval(1000), type: .holiday, hasReminder: false),
            Event(title: "Meeting", date: Date().addingTimeInterval(30000), type: .meeting, hasReminder: true),
            Event(title: "Sport", date: Date().addingTimeInterval(300000), type: .sport, hasReminder: true),
            Event(title: "Other", date: Date().addingTimeInterval(-50000), type: .other, hasReminder: true)
        ]
        self.events = events
    }
    
    func delete(eventID: UUID) {
        events.removeAll { event in
            event.id == eventID
        }
    }
}
