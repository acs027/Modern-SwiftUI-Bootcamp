//
//  RickandMortyApp.swift
//  RickandMorty
//
//  Created by ali cihan on 21.09.2025.
//

import SwiftUI
import SwiftData

@main
struct RickandMortyApp: App {

    var body: some Scene {
        WindowGroup {
            CharacterListView()
                .modelContainer(for: FavoriteCharacter.self)
        }
    }
}
