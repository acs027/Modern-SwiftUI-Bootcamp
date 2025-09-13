//
//  NotesViewModel.swift
//  Notepad
//
//  Created by ali cihan on 11.09.2025.
//

import Foundation
import Observation

@Observable
class NotesViewModel {
    var notes: [Note] = []
    
    
    func fetchNotes() {
       let data = UserDefaults.standard.data(forKey: "MyNotes")
        let decoder = JSONDecoder()
        if let data = data {
            do {
                self.notes = try decoder.decode([Note].self, from: data)
                self.notes.sort { $0.date > $1.date }
            } catch {
                print("Error decoding notes: \(error)")
            }
        }
    }
    
    func saveNotes() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self.notes)
            UserDefaults.standard.set(data, forKey: "MyNotes")
        } catch {
            print("Error encoding notes: \(error)")
        }
    }
    
    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        saveNotes()
    }
    
    func addNote(note: Note) {
        notes.insert(note, at: 0)
        saveNotes()
    }
    
    func loadMockData() {
        let note = Note(title: "Note", content: "Note", date: .now)
        notes.append(note)
    }
    
}
