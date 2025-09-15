//
//  AddNoteSheet.swift
//  Notepad
//
//  Created by ali cihan on 13.09.2025.
//

import SwiftUI

struct AddNoteSheet: View {
    @Environment(\.dismiss) var dismiss
    @State var titleTextField = ""
    @State var contentTextField = ""
    
    let sendNote: (Note) -> ()
    
    var body: some View {
        Form {
            TextField("Title", text: $titleTextField)
            TextEditor(text: $contentTextField)
            Button("Add to my notes") {
                addNote()
            }
        }
    }
    
    private func addNote() {
        let note = Note(title: titleTextField, content: contentTextField, date: Date.now)
        sendNote(note)
        dismiss()
    }
    
}


