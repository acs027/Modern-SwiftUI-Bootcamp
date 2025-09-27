//
//  APIServiceProtocol.swift
//  RickandMorty
//
//  Created by ali cihan on 26.09.2025.
//

import Foundation

protocol APIServiceProtocol {
    func fetchCharacters(completion: @escaping (Result<CharactersResponse, NetworkError>) -> ()) async
    
    func fetchCharactersPage(url: URL?, completion: @escaping (Result<CharactersResponse, NetworkError>) -> ()) async
    
    func fetchCharacters(filters: [CharacterFilter], completion: @escaping (Result<CharactersResponse, NetworkError>) -> ()) async
    
    func fetchCharacters(by ids: [Int], completion: @escaping (Result<[RMCharacter], NetworkError>) -> ()) async
}
