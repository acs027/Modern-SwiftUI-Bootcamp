//
//  NetworkManager.swift
//  Pokedex
//
//  Created by ali cihan on 18.09.2025.
//

import Foundation


protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(urlString: String, decodeTo type: T.Type, completion: @escaping (Result<T, NetworkError>) -> () ) async
}

final class NetworkService: NetworkServiceProtocol {
   
    
    static let shared = NetworkService()
    
    private init() { }
    
    func fetch<T>(urlString: String, decodeTo type: T.Type, completion: @escaping (Result<T, NetworkError>) -> ()) async where T : Decodable {
        do {
            let url = URL(string: urlString)! // Ditto
               let (data, _) = try await URLSession.shared.data(from: url)
               let decodedData = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(.custom(error.localizedDescription)))
        }
    }

}

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case custom(String)
}
