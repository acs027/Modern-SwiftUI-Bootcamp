//
//  NotepadApp.swift
//  Notepad
//
//  Created by ali cihan on 11.09.2025.
//

import SwiftUI

@main
struct NotepadApp: App {
    let manager = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            NotesView()
                .environment(\.managedObjectContext, manager.viewContext)
        }
    }
}
