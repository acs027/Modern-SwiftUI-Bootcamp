//
//  NotesView.swift
//  Notepad
//
//  Created by ali cihan on 11.09.2025.
//

import SwiftUI

struct NotesView: View {
    @State var viewModel = NotesViewModel()
    @State var isAddModalShowing: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notes, id:\.id) { note in
                    NoteRow(note: note)
                }
                .onDelete { indexSet in
                    viewModel.deleteNote(at: indexSet)
                }
            }
            .overlay {
                Circle()
                    .fill(Color.teal)
                    .overlay {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                    }
                    .onTapGesture {
                        isAddModalShowing.toggle()
                    }
                    .frame(width: 50)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding()
            }
            .onAppear {
                viewModel.fetchNotes()
                if viewModel.notes.count < 1 {
                    viewModel.loadMockData()
                }
            }
            .sheet(isPresented: $isAddModalShowing, content: {
                AddNoteSheet() { note in
                    addNote(note: note)
                }
            })
            .navigationTitle("Notes")
        }
    }
    
    private func addNote(note: Note) {
        viewModel.addNote(note: note)
    }
}

#Preview {
    NotesView()
}
