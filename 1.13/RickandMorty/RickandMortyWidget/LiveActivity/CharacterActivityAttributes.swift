//
//  CharacterActivityAttributes.swift
//  RickandMorty
//
//  Created by ali cihan on 18.10.2025.
//

import Foundation
import ActivityKit

struct CharacterActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var date: Date
        var name: String
        var image: String
        var imageData: Data? = nil
    }
}
