//
//  LocationAppShortcutsProvider.swift
//  LocationApp
//
//  Created by ali cihan on 7.10.2025.
//

import Foundation
import AppIntents

struct FavoritesShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: OpenFavoriteLocationIntent(),
            phrases: [
                "Open my favorite locations in \(.applicationName)",
                "Show favorites in \(.applicationName)"
            ],
            shortTitle: "Favorite List",
            systemImageName: "heart.fill"
        )
        
        AppShortcut(
            intent: ShowClosestFavoriteIntent(),
            phrases: [
                "Show my closest favorites in \(.applicationName)"
            ],
            shortTitle: "Closest Favorite",
            systemImageName: "heart.fill"
        )
    }
}
