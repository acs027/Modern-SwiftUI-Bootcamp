//
//  PokemonListResponse.swift
//  Pokedex
//
//  Created by ali cihan on 18.09.2025.
//

import Foundation

struct PokemonListResponse: Decodable {
    let count: Int
    var next: String?
    var previous: String?
    var results: [PokemonListItem]
}

struct PokemonListItem: Decodable, Identifiable {
    let name: String
    let url: String
    
    var id: Int {
        if let last = url.split(separator: "/").last,
           let id = Int(last) {
            return id
        }
        return -1
    }
    
    enum CodingKeys: String, CodingKey {
        // list endpoint keys
        case name
        case url
        // detail endpoint keys
        case id
        case identifier
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Case 1: list endpoint (has name + url)
        if let name = try? container.decode(String.self, forKey: .name),
           let url = try? container.decode(String.self, forKey: .url) {
            self.name = name
            self.url = url
            return
        }
        
        // Case 2: detail endpoint (has id + identifier)
        if let identifier = try? container.decode(String.self, forKey: .identifier),
           let id = try? container.decode(Int.self, forKey: .id) {
            self.name = identifier
            self.url = "https://pokeapi.co/api/v2/pokemon/\(id)/"
            return
        }
        
        throw DecodingError.dataCorrupted(
            DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "PokemonListItem JSON didn’t match list or detail format"
            )
        )
    }
}

