//
//  EditNoteSheet.swift
//  Notepad
//
//  Created by ali cihan on 14.09.2025.
//

import SwiftUI

struct EditNoteSheet: View {
    @Environment(\.dismiss) var dismiss
    @State var titleTextField = ""
    @State var contentTextField = ""
    var note: Note
    let sendNote: (Note) -> ()
    
    var body: some View {
        Form {
            TextField("Title", text: $titleTextField)
            TextEditor(text: $contentTextField)
            Button("Edit the note") {
                updateNote()
            }
        }
        .onAppear {
            titleTextField = note.title
            contentTextField = note.content
        }
    }
    
    private func updateNote() {
        let editedNote = Note(id: note.id, title: titleTextField, content: contentTextField, date: Date.now)
        sendNote(editedNote)
        dismiss()
    }
    
}
