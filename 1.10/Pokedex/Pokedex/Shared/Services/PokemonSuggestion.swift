//
//  PokemonSuggestion.swift
//  Pokedex
//
//  Created by ali cihan on 18.09.2025.
//

import Foundation

final class PokemonSuggestions {
    static func loadIdentifiers() -> [PokemonListItem] {
        guard let url = Bundle.main.url(forResource: "pokemons", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let pokemons = try? JSONDecoder().decode([PokemonListItem].self, from: data) else {
            return []
        }
        return pokemons
    }
}
