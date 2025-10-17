//
//  APIService.swift
//  RickandMorty
//
//  Created by ali cihan on 21.09.2025.
//

import Foundation

final class APIService: APIServiceProtocol {
    private let baseURL = "https://rickandmortyapi.com/api/character/"
    private let cacheService = CacheService.shared
    
    // Fetch all characters
    func fetchCharacters(completion: @escaping (Result<CharactersResponse, NetworkError>) -> ()) async {
        guard let url = URL(string: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }
        await fetchCharacters(from: url, completion: completion)
    }
    
    func fetchCharactersPage(url: URL?, completion: @escaping (Result<CharactersResponse, NetworkError>) -> ()) async {
        guard let pageURL = url else {
            completion(.failure(.invalidURL))
            return
        }
        await fetchCharacters(from: pageURL, completion: completion)
    }
    
    // Fetch with filters
    func fetchCharacters(filters: [CharacterFilter], completion: @escaping (Result<CharactersResponse, NetworkError>) -> ()) async {
        var components = URLComponents(string: baseURL)
        components?.queryItems = filters.map { $0.queryItem }
        
        guard let url = components?.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        await fetchCharacters(from: url, completion: completion)
    }
    
    // Fetch multiple characters by IDs
    func fetchCharacters(by ids: [Int], completion: @escaping (Result<[RMCharacter], NetworkError>) -> ()) async {
        var found: [RMCharacter] = []
        var missing: [Int] = []
        
        // Check in-memory cache first
        for id in ids {
            if let cached = CharacterCache.shared.get(id: id) {
                found.append(cached)
            } else {
                missing.append(id)
            }
        }
        
        // If everything cached, return
        if missing.isEmpty {
            completion(.success(found))
            return
        }
        
        // Fetch missing IDs
        let idString = missing.map(String.init).joined(separator: ",")
        guard let url = URL(string: "\(baseURL)/\(idString)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        do {
            let (data, response) = try await NetworkService.fetch(url: url)
            cacheService.store(data, response: response, for: URLRequest(url: url))
            
            let decoded: [RMCharacter] = try JSONDecoder().decode([RMCharacter].self, from: data)
            CharacterCache.shared.set(decoded) // store in-memory
            completion(.success(found + decoded))
        } catch {
            completion(.failure(.custom(error.localizedDescription)))
        }
    }
    
    // MARK: - Private helper
    private func fetchCharacters(from url: URL, completion: @escaping (Result<CharactersResponse, NetworkError>) -> ()) async {
        let request = URLRequest(url: url)
        
        // 1. Try URLCache first
        if let cached: CharactersResponse = cacheService.get(for: request, decodeTo: CharactersResponse.self) {
            completion(.success(cached))
            return
        }
        
        // 2. Network fallback
        do {
            let (data, response) = try await NetworkService.fetch(url: url)
            cacheService.store(data, response: response, for: request)
            
            let decoded = try JSONDecoder().decode(CharactersResponse.self, from: data)
            completion(.success(decoded))
        } catch {
            print(error.localizedDescription)
            completion(.failure(.custom(error.localizedDescription)))
        }
    }
}



// MARK: - Character Filter
enum CharacterFilter {
    case name(String)
    case status(String)   // alive, dead, unknown
    case species(String)
    case type(String)
    case gender(String)   // female, male, genderless, unknown
    
    var queryItem: URLQueryItem {
        switch self {
        case .name(let value):
            return URLQueryItem(name: "name", value: value)
        case .status(let value):
            return URLQueryItem(name: "status", value: value)
        case .species(let value):
            return URLQueryItem(name: "species", value: value)
        case .type(let value):
            return URLQueryItem(name: "type", value: value)
        case .gender(let value):
            return URLQueryItem(name: "gender", value: value)
        }
    }
}
