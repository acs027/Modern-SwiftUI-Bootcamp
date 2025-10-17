//
//  SimpleEntry.swift
//  RickandMorty
//
//  Created by ali cihan on 17.10.2025.
//

import WidgetKit

struct RMCharacterEntry: TimelineEntry {
    var date: Date
    let name: String
    let image: String
    var imageData: Data? = nil
}
