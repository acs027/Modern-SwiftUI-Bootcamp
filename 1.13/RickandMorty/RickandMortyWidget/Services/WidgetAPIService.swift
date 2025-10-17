//
//  RMCharacterService.swift
//  RickandMorty
//
//  Created by ali cihan on 17.10.2025.
//

import Foundation

//let charIds = characters.map { $0.id }
//let ids = favorites.filter { id in
//    !charIds.contains(id)
//}
//isLoading = true
//await apiService.fetchCharacters(by: ids) { result in
//    switch result {
//    case .success(let response):
//        self.charactersSet.formUnion(response)
//        self.isLoading = false
//    case .failure(let failure):
//        self.errorMessage = failure.localizedDescription
//        self.isLoading = false
//    }
//}


class WidgetAPIService {
    private let baseURL = "https://rickandmortyapi.com/api/character/"
    
    func fetchCharacters(by id: Int, completion: @escaping (Result<RMCharacter, NetworkError>) -> ()) async {
        // Fetch missing IDs
        guard let url = URL(string: "\(baseURL)/\(id)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        do {
            let request = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: request)
            let decoded: RMCharacter = try JSONDecoder().decode(RMCharacter.self, from: data)
            completion(.success(decoded))
        } catch {
            completion(.failure(.custom(error.localizedDescription)))
        }
    }
    
    func fetchCharacter(by id: Int) async throws -> RMCharacter {
        // Fetch missing IDs
        guard let url = URL(string: "\(baseURL)/\(id)") else {
            throw URLError(.badURL)
        }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        let decoded: RMCharacter = try JSONDecoder().decode(RMCharacter.self, from: data)
        return decoded
    }
    
    func fetchImageData(url: URL?) async -> Data? {
        guard let url else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print("image data ready")
            return data
        } catch {
            return nil
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case custom(String)
}
