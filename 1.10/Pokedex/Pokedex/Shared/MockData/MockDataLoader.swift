//
//  MockDataService.swift
//  Pokedex
//
//  Created by ali cihan on 18.09.2025.
//

import Foundation

final class MockDataLoader {    
    static func loadPokemonList() -> PokemonListResponse? {
            guard let url = Bundle.main.url(forResource: "PokemonListResponse", withExtension: "json") else {
                print("JSON file not found")
                return nil
            }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                return try decoder.decode(PokemonListResponse.self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
                return nil
            }
        }
    
    static func loadPokemon() -> Pokemon? {
            guard let url = Bundle.main.url(forResource: "Pikachu", withExtension: "json") else {
                print("JSON file not found")
                return nil
            }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                return try decoder.decode(Pokemon.self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
                return nil
            }
        }
}
