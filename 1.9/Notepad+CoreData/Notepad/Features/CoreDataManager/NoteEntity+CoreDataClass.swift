//
//  NoteEntity+CoreDataClass.swift
//  Notepad
//
//  Created by ali cihan on 14.09.2025.
//
//

import Foundation
import CoreData

@objc(NoteEntity)
public class NoteEntity: NSManagedObject {

}

extension NoteEntity {
    
    // MARK: - Update
    func update(
        note: Note
    ) {
        
        self.id = note.id
        self.title = note.title
        self.content = note.content
        self.date = note.date
    }
    
    func toNote() -> Note {
           Note(
               id: self.id,
               title: self.title ?? "",
               content: self.content ?? "",
               date: self.date ?? Date()
           )
       }
}
