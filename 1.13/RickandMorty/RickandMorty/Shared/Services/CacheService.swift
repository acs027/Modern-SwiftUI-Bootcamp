//
//  CacheService.swift
//  RickandMorty
//
//  Created by ali cihan on 22.09.2025.
//

import Foundation

final class CacheService {
    static let shared = CacheService()
    private let cache = URLCache.shared
    
    private init() {}
    
    func get<T: Decodable>(for request: URLRequest, decodeTo type: T.Type) -> T? {
        guard let cachedResponse = cache.cachedResponse(for: request) else { return nil }
        return try? JSONDecoder().decode(T.self, from: cachedResponse.data)
    }
    
    func store(_ data: Data, response: URLResponse, for request: URLRequest) {
        let cachedData = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedData, for: request)
    }
}

final class CharacterCache {
    static let shared = CharacterCache()
    private var cache: [Int: RMCharacter] = [:]
    
    private init() {}
    
    func get(id: Int) -> RMCharacter? { cache[id] }
    func set(_ character: RMCharacter) { cache[character.id] = character }
    func set(_ characters: [RMCharacter]) {
        characters.forEach { cache[$0.id] = $0 }
    }
}
