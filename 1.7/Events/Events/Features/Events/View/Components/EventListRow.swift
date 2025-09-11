//
//  EventListRow.swift
//  Events
//
//  Created by ali cihan on 11.09.2025.
//

import SwiftUI

struct EventListRow: View {
    let event: Event
    var body: some View {
        NavigationLink {
             EventDetailView(event: event)
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(event.title)
                        .bold()
                        .font(.headline)
                    Text(event.remainingTime)
                }
                Spacer()
                VStack {
                    Image(systemName: event.type.imageName)
                    Text(event.type.rawValue)
                }
                Spacer()
                Image(systemName: event.hasReminder ? "bell" : "bell.slash")
                    .bold()
                    .font(.title)
            }
        }
    }
}

#Preview {
    EventListRow(event: Event(title: "Birtday", date: .now, type: .birthday, hasReminder: true))
}
