//
//  NoteRow.swift
//  Notepad
//
//  Created by ali cihan on 13.09.2025.
//

import SwiftUI

struct NoteRow: View {
    let note: Note
    @State var isNoteExpanded: Bool = false
    let randomColor: Color = Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), opacity: 0.7)
    
    var body: some View {
        content(note: note)
            .listRowBackground(randomColor)
            .onTapGesture {
                isNoteExpanded.toggle()
                
            }
    }
    
    private func content(note: Note) -> some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(note.title)
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
                    Text(note.content)
                    Text(note.date.formatted())
                        .font(.footnote)
                }
            }
        }
        .contentShape(Rectangle())
        .animation(.easeInOut, value: isNoteExpanded)
    }
}
