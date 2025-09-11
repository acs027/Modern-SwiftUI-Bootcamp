//
//  EventType.swift
//  Events
//
//  Created by ali cihan on 11.09.2025.
//

import Foundation

enum EventType: String, CaseIterable, Codable, Identifiable {
    var id: String { rawValue }
    case birthday = "Birthday"
    case meeting = "Meeting"
    case holiday = "Holiday"
    case sport = "Sport"
    case other = "Other"
    var imageName: String {
        switch self {
        case .birthday:
            return "birthday.cake"
        case .meeting:
            return "calendar.and.person"
        case .holiday:
            return "rainbow"
        case .sport:
            return "figure.run.treadmill"
        case .other:
            return "calendar"
        }
    }
}
