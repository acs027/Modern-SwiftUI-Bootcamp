//
//  PokemonService.swift
//  Pokedex
//
//  Created by ali cihan on 18.09.2025.
//

import Foundation

protocol PokemonServiceProtocol {
    func fetchPokemon(queryString: String, completion: @escaping (Result<Pokemon, NetworkError>) -> ()) async
    func fetchPokemons(queryString: String, completion: @escaping (Result<PokemonListResponse, NetworkError>) -> ()) async
    func fetchPokemons(completion: @escaping (Result<PokemonListResponse, NetworkError>) -> ()) async
}

final class PokemonService: PokemonServiceProtocol {
   
    
    private let networkService: NetworkServiceProtocol
    private let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func fetchPokemon(queryString: String, completion: @escaping (Result<Pokemon, NetworkError>) -> ()) async {
        let constructedURLString = baseURL + queryString
        await networkService.fetch(urlString: constructedURLString, decodeTo: Pokemon.self, completion: completion)
    }
    
    func fetchPokemons(completion: @escaping (Result<PokemonListResponse, NetworkError>) -> ()) async {
        await networkService.fetch(urlString: baseURL, decodeTo: PokemonListResponse.self, completion: completion)
    }
    
    
    func fetchPokemons(queryString: String, completion: @escaping (Result<PokemonListResponse, NetworkError>) -> ()) async {
        await networkService.fetch(urlString: queryString, decodeTo: PokemonListResponse.self, completion: completion)
    }
    
}
