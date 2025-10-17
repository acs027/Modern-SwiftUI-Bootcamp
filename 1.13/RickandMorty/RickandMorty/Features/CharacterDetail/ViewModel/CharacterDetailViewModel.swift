//
//  CharacterDetailViewModel.swift
//  RickandMorty
//
//  Created by ali cihan on 24.09.2025.
//

import Foundation
import Observation

@Observable
final class CharacterDetailViewModel {
    let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
}
