//
//  NoteRow.swift
//  Notepad
//
//  Created by ali cihan on 13.09.2025.
//

import SwiftUI

struct NoteRow: View {
    let note: NoteEntity
    @State var isNoteExpanded: Bool = false
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        content(note: note)
            .listRowBackground(Color.teal)
            .onTapGesture {
                isNoteExpanded.toggle()
                
            }
            .swipeActions(edge: .leading) {
                NavigationLink("Edit") {
                    EditNoteSheet(note: note.toNote()) { note in
                        updateNote(note: note)
                    }
                }
            }
    }
    
    private func content(note: NoteEntity) -> some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(note.title ?? "Unkown")
                        .bold()
                        .font(.headline)
                        .frame(height: 40)
                }
                Spacer()
                Circle()
                    .fill(Color.white)
                    .frame(width: 40)
                    .overlay {
                        Image(systemName: isNoteExpanded ? "chevron.up.2" : "chevron.down.2")
                    }
            }
            if isNoteExpanded {
                VStack(alignment: .leading, spacing: 6) {
                    Text(note.content ?? "Unknown")
                    Text(note.date?.formatted() ?? "Unknown")
                        .font(.footnote)
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.ultraThinMaterial)
                }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
        }
        .contentShape(Rectangle())
        .animation(.easeInOut, value: isNoteExpanded)
    }
    
    private func updateNote(note: Note) {
        NotesService.updateNote(with: note, in: context)
    }
}
