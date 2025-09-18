//
//  Pokemon.swift
//  Pokedex
//
//  Created by ali cihan on 18.09.2025.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let name: String
    let baseExperience: Int
    let height: Int
    let weight: Int
    
    let abilities: [PokemonAbility]
    let cries: PokemonCries
    let gameIndices: [PokemonGameIndex]
    let heldItems: [PokemonHeldItem]
    let moves: [PokemonMove]
    let species: NamedAPIResource
    let sprites: PokemonSprites
    let stats: [PokemonStat]
    let types: [PokemonType]
    let pastAbilities: [PokemonPastAbility]

    enum CodingKeys: String, CodingKey {
        case id, name, height, weight, abilities, cries, species, sprites, stats, types
        case baseExperience = "base_experience"
        case gameIndices = "game_indices"
        case heldItems = "held_items"
        case moves
        case pastAbilities = "past_abilities"
    }
}

// MARK: - Abilities
struct PokemonAbility: Decodable {
    let ability: NamedAPIResource
    let isHidden: Bool
    let slot: Int
    
    enum CodingKeys: String, CodingKey {
        case ability, slot
        case isHidden = "is_hidden"
    }
}

// MARK: - Cries
struct PokemonCries: Decodable {
    let latest: String
    let legacy: String?
}

// MARK: - Game Index
struct PokemonGameIndex: Decodable {
    let gameIndex: Int
    let version: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}

// MARK: - Held Items
struct PokemonHeldItem: Decodable {
    let item: NamedAPIResource
    let versionDetails: [PokemonHeldItemVersion]
    
    enum CodingKeys: String, CodingKey {
        case item
        case versionDetails = "version_details"
    }
}

struct PokemonHeldItemVersion: Decodable {
    let rarity: Int
    let version: NamedAPIResource
}

// MARK: - Moves
struct PokemonMove: Decodable {
    let move: NamedAPIResource
    let versionGroupDetails: [PokemonMoveVersion]
    
    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

struct PokemonMoveVersion: Decodable {
    let levelLearnedAt: Int
    let moveLearnMethod: NamedAPIResource
    let versionGroup: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}

// MARK: - Sprites
struct PokemonSprites: Decodable {
    let frontDefault: String?
    let other: PokemonOtherSprites?
    let versions: [String: [String: PokemonVersionSprite]?]?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other
        case versions
    }
}

struct PokemonOtherSprites: Decodable {
    let officialArtwork: PokemonArtwork?
    let dreamWorld: PokemonImageSet?
    let home: PokemonImageSet?
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
        case dreamWorld = "dream_world"
        case home
    }
}

struct PokemonArtwork: Decodable {
    let frontDefault: String?
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonImageSet: Decodable {
    let frontDefault: String?
    let frontShiny: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

struct PokemonVersionSprite: Decodable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - Stats
struct PokemonStat: Decodable {
    let baseStat: Int
    let effort: Int
    let stat: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - Types
struct PokemonType: Decodable {
    let slot: Int
    let type: NamedAPIResource
}

// MARK: - Past Abilities
struct PokemonPastAbility: Decodable {
    let abilities: [PokemonAbilityWrapper]
    let generation: NamedAPIResource
}

struct PokemonAbilityWrapper: Decodable {
    let ability: NamedAPIResource?
    let isHidden: Bool
    let slot: Int
    
    enum CodingKeys: String, CodingKey {
        case ability, slot
        case isHidden = "is_hidden"
    }
}

// MARK: - Shared Resource
struct NamedAPIResource: Decodable {
    let name: String
    let url: String
}
