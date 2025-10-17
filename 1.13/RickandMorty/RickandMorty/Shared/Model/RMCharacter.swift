//
//  RMCharacter.swift
//  RickandMorty
//
//  Created by ali cihan on 21.09.2025.
//

import Foundation

// MARK: - Top-Level Response
struct CharactersResponse: Decodable {
    let info: PageInfo
    let results: [RMCharacter]
}

// MARK: - Page Info
struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - RMCharacter
struct RMCharacter: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: CharacterSpecies
    let type: String
    let gender: CharacterGender
    let origin: LocationInfo
    let location: LocationInfo
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    static func == (lhs: RMCharacter, rhs: RMCharacter) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
          hasher.combine(id)
      }
}


enum CharacterStatus: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var symbolName: String {
        switch self {
        case .alive: return "heart.fill"
        case .dead: return "xmark.octagon.fill"
        case .unknown: return "questionmark.circle.fill"
        }
    }
    
    var rgba: RGBA {
        switch self {
        case .alive:
            RGBA.green()
        case .dead:
            RGBA.red()
        case .unknown:
            RGBA.gray()
        }
    }
}

enum CharacterSpecies: Decodable {
    case human, alien, robot, unknown(String)
    
    var symbolName: String {
        switch self {
        case .human: return "person.fill"
        case .alien: return "antenna.radiowaves.left.and.right"
        case .robot: return "cpu"
        case .unknown: return "questionmark.circle"
        }
    }
    
    var rawValue: String {
            switch self {
            case .human: return "Human"
            case .alien: return "Alien"
            case .robot: return "Robot"
            case .unknown(let raw): return raw
            }
        }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.singleValueContainer()
           let raw = try container.decode(String.self)
           switch raw {
           case "Human": self = .human
           case "Alien": self = .alien
           case "Robot": self = .robot
           default: self = .unknown(raw)
           }
       }
}

enum CharacterGender: Decodable {
    case male, female, genderless, unknown(String)
    
    var symbolName: String {
        switch self {
        case .male, .female: return "person.fill"
        case .genderless: return "figure.stand"
        case .unknown: return "questionmark.circle"
        }
    }
    
    var rgba: RGBA {
        switch self {
        case .male:
            RGBA.blue()
        case .female:
            RGBA(r: 1, g: 20/255, b: 147/255, a: 0.4)
        case .genderless, .unknown:
            RGBA.gray()
        }
    }
    
    var rawValue: String {
        switch self {
        case .male:
            "Male"
        case .female:
            "Female"
        case .genderless:
            "Genderless"
        case .unknown(let string):
            string.capitalized
        }
        }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.singleValueContainer()
           let raw = try container.decode(String.self)
           switch raw {
           case "Male": self = .male
           case "Female": self = .female
           case "Genderless": self = .genderless
           default: self = .unknown(raw)
           }
       }
}

// MARK: - Location Info
struct LocationInfo: Codable {
    let name: String
    let url: String
}

