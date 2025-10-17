//
//  NetworkService.swift
//  RickandMorty
//
//  Created by ali cihan on 21.09.2025.
//

import Foundation

final class NetworkService {
    static func fetch(url: URL) async throws -> (Data, URLResponse) {
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        return try await URLSession.shared.data(for: request)
    }
}


enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case custom(String)
}
