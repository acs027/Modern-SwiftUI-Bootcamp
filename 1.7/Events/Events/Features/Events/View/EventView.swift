//
//  EventView.swift
//  Events
//
//  Created by ali cihan on 10.09.2025.
//

import SwiftUI

struct EventView: View {
    @State var viewModel = EventViewModel()
    @State var isModalShowing = false
    
    var body: some View {
        NavigationStack {
            List {
                activeEvents
                expiredEvents
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isModalShowing.toggle()
                    } label: {
                        Image(systemName: "plus.app")
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadMockData()
        }
        .sheet(isPresented: $isModalShowing) {
            EventAddView { newEvent in
                addEvent(event: newEvent)
            }
        }
    }
    
    @ViewBuilder
    var activeEvents: some View {
        let activeEvents = viewModel.events.filter({ $0.isActive }).sorted {
            $0.date < $1.date
        }
        Section("Active Events") {
            ForEach(activeEvents, id:\.id) { event in
                EventListRow(event: event)
            }
            .onDelete { indexSet in
                for index in indexSet {
                    let event = activeEvents[index]
                    deleteEvent(eventID: event.id)
                }
            }
        }
    }
    
    @ViewBuilder
    var expiredEvents: some View {
        let expiredEvents = viewModel.events.filter( { !$0.isActive }).sorted {
            $0.date < $1.date
        }
        Section("Expired Events") {
            ForEach(expiredEvents, id:\.id) { event in
                EventListRow(event: event)
            }
            .onDelete { indexSet in
                for index in indexSet {
                    let event = expiredEvents[index]
                    deleteEvent(eventID: event.id)
                }
            }
        }
    }
    
    private func deleteEvent(eventID: UUID) {
        viewModel.delete(eventID: eventID)
    }
    
    private func addEvent(event: Event) {
        viewModel.addEvent(event: event)
    }
}




#Preview {
    EventView()
}
