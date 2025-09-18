//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by ali cihan on 18.09.2025.
//

import Foundation
import Observation

@Observable
final class PokemonDetailViewModel {
    var pokemon: Pokemon?
    private let service = PokemonService()
    
    var types: String {
        pokemon?.types.compactMap({ $0.type.name.capitalized }).joined(separator: ",") ?? ""
    }
    
    func fetchPokemonData(queryString: String) async {
        await service.fetchPokemon(queryString: queryString) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let pokemon):
                self.pokemon = pokemon
            case .failure(let failure):
                debugPrint(failure.localizedDescription)
            }
        }
    }
}
