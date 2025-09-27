//
//  MockDataService.swift
//  RickandMorty
//
//  Created by ali cihan on 22.09.2025.
//

import Foundation

final class MockDataService {
    static func fetchMockCharacter() -> RMCharacter {
           guard let url = Bundle.main.url(forResource: "RMCharacter", withExtension: "json") else {
               fatalError("RMCharacter.json not found")
           }
           
           do {
               let data = try Data(contentsOf: url)
               let character = try JSONDecoder().decode(RMCharacter.self, from: data)
               return character
           } catch {
               fatalError("Failed to decode RMCharacter.json: \(error)")
           }
       }
    
    static func fetchMockCharacters() -> CharactersResponse {
           guard let url = Bundle.main.url(forResource: "CharactersResponse", withExtension: "json") else {
               fatalError("CharactersResponse.json not found")
           }
           
           do {
               let data = try Data(contentsOf: url)
               let response = try JSONDecoder().decode(CharactersResponse.self, from: data)
               return response
           } catch {
               fatalError("Failed to decode ChacractersResponse.json: \(error)")
           }
       }
}
