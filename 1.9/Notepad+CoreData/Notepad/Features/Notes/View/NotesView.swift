//
//  NotesView.swift
//  Notepad
//
//  Created by ali cihan on 11.09.2025.
//

import SwiftUI

struct NotesView: View {
    @Environment(\.managedObjectContext) private var context
    @State var isAddModalShowing: Bool = false
    @State var searchText: String = ""
    
    @FetchRequest(
            entity: NoteEntity.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \NoteEntity.date, ascending: false)]
        ) private var noteEntities: FetchedResults<NoteEntity>
    
    
    private var filteredNotes: [NoteEntity] {
        if searchText.isEmpty {
                  return Array(noteEntities)
              } else {
                  return noteEntities.filter { note in
                      let titleMatch = note.title?.localizedCaseInsensitiveContains(searchText) ?? false
                      let contentMatch = note.content?.localizedCaseInsensitiveContains(searchText) ?? false
                      return titleMatch || contentMatch
                  }
              }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredNotes, id:\.objectID) { note in
                    NoteRow(note: note)
                }
                .onDelete { indexSet in
                    deleteNotes(offsets: indexSet)
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
            .sheet(isPresented: $isAddModalShowing, content: {
                AddNoteSheet() { note in
                    addNote(note: note)
                }
            })
            .navigationTitle("Notes")
            .onAppear {
                if noteEntities.isEmpty {
                    addMockNotes()
                }
            }
        }
        .searchable(text: $searchText)
    }
    
    private func addMockNotes() {
        Note.mockNotes.forEach({
            addNote(note: $0)
        })
    }
    
    private func addNote(note: Note) {
        NotesService.addNote(note, to: context)
    }
    
    private func deleteNotes(offsets: IndexSet) {
        let notes = offsets.map { filteredNotes[$0] }
        NotesService.deleteNotes(notes, from: context)
    }
}

#Preview {
    NotesView()
}
