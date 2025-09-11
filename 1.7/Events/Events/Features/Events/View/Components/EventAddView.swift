//
//  EventAddView.swift
//  Events
//
//  Created by ali cihan on 11.09.2025.
//

import SwiftUI

struct EventAddView: View {
    @Environment(\.dismiss) var dismiss
    @State var title = ""
    @State var date: Date = .now
    @State var type: EventType = .other
    @State var hasReminder = false
    let addEvent: (Event) -> Void
    
    var body: some View {
        Form {
            Section("Title") {
                TextField("Title", text: $title)
            }
            Section("Date") {
                DatePicker("Date", selection: $date)
            }
            
            Section("Event Type") {
                Picker("Pick a type", selection: $type) {
                    ForEach(EventType.allCases, id:\.id) { type in
                        Text(type.id).tag(type)
                    }
                }
            }
            
            Section("Reminder") {
                Toggle("Reminder", isOn: $hasReminder)
            }
        }
        Button {
            addEventHandler()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .overlay {
                    Text("Add Event")
                        .foregroundStyle(.white)
                }
                .frame(width: 100, height: 50)
        }
    }
    
    private func addEventHandler() {
        let event = Event(title: title, date: date, type: type, hasReminder: hasReminder)
        addEvent(event)
        dismiss()
    }
}
