//
//  MockAPIService.swift
//  RickandMorty
//
//  Created by ali cihan on 27.09.2025.
//


import Foundation

final class MockAPIService: APIServiceProtocol {
    
    // Fetch all characters
    func fetchCharacters(completion: @escaping (Result<CharactersResponse, NetworkError>) -> ()) async {
        await fetchCharactersFromMockData(completion: completion)
    }
    
    func fetchCharactersPage(url: URL?, completion: @escaping (Result<CharactersResponse, NetworkError>) -> ()) async {
        await fetchCharactersFromMockData(completion: completion)
    }
    
    // Fetch with filters
    func fetchCharacters(filters: [CharacterFilter], completion: @escaping (Result<CharactersResponse, NetworkError>) -> ()) async {
        await fetchCharactersFromMockData(completion: completion)
    }
    
    // Fetch multiple characters by IDs
    func fetchCharacters(by ids: [Int], completion: @escaping (Result<[RMCharacter], NetworkError>) -> ()) async {
    }
    
    // MARK: - Private helper
    private func fetchCharactersFromMockData(completion: @escaping (Result<CharactersResponse, NetworkError>) -> ()) async {
        let response = MockDataService.fetchMockCharacters()
        completion(.success(response))
    }
}
