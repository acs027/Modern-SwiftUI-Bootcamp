//
//  Event.swift
//  Events
//
//  Created by ali cihan on 10.09.2025.
//

import Foundation

struct Event: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var title: String
    var date: Date
    var type: EventType
    var hasReminder: Bool
    
    var isActive: Bool {
        let now = Date()
        return date > now
    }
    
    var remainingTime: String {
           let now = Date()
           if date < now {
               return "Expired"
           }

           let components = Calendar.current.dateComponents([.day, .hour, .minute], from: now, to: date)

           if let days = components.day, days > 0 {
               return "\(days) day(s) left"
           } else if let hours = components.hour, hours > 0 {
               return "\(hours) hour(s) left"
           } else if let minutes = components.minute, minutes > 0 {
               return "\(minutes) min(s) left"
           } else {
               return "Soon"
           }
       }
}
