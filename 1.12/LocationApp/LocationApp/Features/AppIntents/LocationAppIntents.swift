//
//  LocationAppIntents.swift
//  LocationApp
//
//  Created by ali cihan on 7.10.2025.
//

import AppIntents
import SwiftUI

struct OpenFavoriteLocationIntent: AppIntent {
    static var title: LocalizedStringResource = "Open Favorite Locations"
    static var description = IntentDescription("Opens the app and shows your list of favorite locations.")

    
    static let supportedModes: IntentModes = .foreground
    
    @MainActor
    func perform() async throws -> some IntentResult {
        print("Opening your favorite locations")

        NotificationCenter.default.post(
               name: Notification.Name("OpenFavoritesIntent"),
               object: nil
           )
        
        return .result()
    }
}

struct ShowClosestFavoriteIntent: AppIntent {
    static var title: LocalizedStringResource = "Show Closest Favorite Location"
    static var description = IntentDescription("Opens the app and shows closest favorite location.")

    
    static let supportedModes: IntentModes = .foreground
    
    @MainActor
    func perform() async throws -> some IntentResult {
        print("Opening your closest favorite location")

        NotificationCenter.default.post(
               name: Notification.Name("ShowClosestIntent"),
               object: nil
           )
        return .result()
    }
}
