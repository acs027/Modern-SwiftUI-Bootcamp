//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by ali cihan on 18.09.2025.
//

import Foundation
import Observation

@Observable
final class PokemonListViewModel {
    private var pokemonListResponse: PokemonListResponse?
    private let service = PokemonService()
    var filterText = ""
    var pokemonList: [PokemonListItem] {
        if filterText.isEmpty {
            guard let pokemons = pokemonListResponse?.results else { return [] }
            return pokemons
        } else {
            guard let pokemons = pokemonListResponse?.results.filter({$0.name.localizedCaseInsensitiveContains(filterText)}) else { return [] }
            return pokemons
        }
    }
    
    var allPokemons: [PokemonListItem] {
        PokemonSuggestions.loadIdentifiers()
    }
    
    var isLoading: Bool = false
    
    func fetchPokemons() async {
        isLoading = true
        await service.fetchPokemons { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let pokemonListResponse):
                self.pokemonListResponse = pokemonListResponse
                isLoading = false
            case .failure(let failure):
                debugPrint(failure.localizedDescription)
                isLoading = false
            }
        }
//#endif // DEBUG
    }
    
    func loadMore() async {
        isLoading = true
        guard let nextURLString = pokemonListResponse?.next else { return }
        await service.fetchPokemons(queryString: nextURLString) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let pokemonListResponse):
                self.pokemonListResponse?.next = pokemonListResponse.next
                self.pokemonListResponse?.previous = pokemonListResponse.previous
                self.pokemonListResponse?.results.append(contentsOf: pokemonListResponse.results)
                
                isLoading = false
            case .failure(let failure):
                debugPrint(failure.localizedDescription)
                isLoading = false
            }
        }
    }
    
    func getSuggestion() -> [PokemonListItem] {
        allPokemons.filter({
            $0.name.localizedCaseInsensitiveContains(filterText)
        })
    }
    
    func getImageUrlString(pokemonID: Int) ->String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(pokemonID).png"
    }
    
    func addPokemon(item: PokemonListItem) {
        guard let results = pokemonListResponse?.results else { return }
        if results.contains(where: {$0.id == item.id}) { return }
        pokemonListResponse?.results.append(item)
    }
    
    func addPokemon() {
        guard let item = allPokemons.first(where: {$0.name.lowercased() == filterText.lowercased()}) else { return }
        guard let results = pokemonListResponse?.results else { return }
        if results.contains(where: {$0.id == item.id}) { return }
        pokemonListResponse?.results.append(item)
    }
}
