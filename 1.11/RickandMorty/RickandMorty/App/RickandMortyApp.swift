//
//  RickandMortyApp.swift
//  RickandMorty
//
//  Created by ali cihan on 21.09.2025.
//

import SwiftUI
import CoreData

@main
struct RickandMortyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CharacterListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
