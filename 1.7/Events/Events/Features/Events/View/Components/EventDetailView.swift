//
//  EventDetailView.swift
//  Events
//
//  Created by ali cihan on 11.09.2025.
//

import SwiftUI

struct EventDetailView: View {
    let event: Event
    var body: some View {
        Form {
            Section("Title") {
                Text(event.title)
            }
            Section("Date") {
                Text(event.date.formatted())
                Text(event.remainingTime)
            }
            
            Section("Event Type") {
                HStack {
                    Text(event.type.id)
                    Image(systemName: event.type.imageName)
                }
            }
            Section("Reminder") {
                Text(event.hasReminder ? "On" : "Off")
            }
        }
    }
}

#Preview {
    EventDetailView(event: Event(title: "Birtday", date: .now, type: .birthday, hasReminder: true))
}
