//
//  NotesService.swift
//  Notepad
//
//  Created by ali cihan on 15.09.2025.
//

import Foundation
import CoreData

final class NotesService {
    
    static func addNote(_ note: Note, to context: NSManagedObjectContext) {
        let noteEntity = NoteEntity(context: context)
        noteEntity.update(note: note)
        saveContext(context)
    }
    
    static func updateNote(with note: Note, in context: NSManagedObjectContext) {
        let noteEntity = NoteEntity(context: context)
        noteEntity.update(note: note)
        saveContext(context)
    }
    
    static func deleteNotes(_ noteEntities: [NoteEntity], from context: NSManagedObjectContext) {
        noteEntities.forEach(context.delete)
        saveContext(context)
    }
    
    private static func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
}
