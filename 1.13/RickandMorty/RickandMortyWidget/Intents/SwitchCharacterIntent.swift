//
//  SwitchCharacterIntent.swift
//  RickandMorty
//
//  Created by ali cihan on 18.10.2025.
//

import Foundation
import AppIntents
import WidgetKit

struct SwitchCharacterIntent: AppIntent {
    static var title: LocalizedStringResource = "Switch between your favorite characters"
    static var description: IntentDescription = IntentDescription("Switching the background image.")
    
    func perform() async throws -> some IntentResult {
        print("Intent Switch Button")
        WidgetCenter.shared.reloadAllTimelines()
        return .result()
    }
}
