//
//  Note.swift
//  Notepad
//
//  Created by ali cihan on 11.09.2025.
//

import Foundation

struct Note: Codable, Identifiable {
    var id: UUID = UUID()
    var title: String
    var content: String
    var date: Date
}
