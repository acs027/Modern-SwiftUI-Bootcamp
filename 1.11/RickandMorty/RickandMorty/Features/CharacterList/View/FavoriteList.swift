//
//  FavoriteList.swift
//  RickandMorty
//
//  Created by ali cihan on 26.09.2025.
//

import SwiftUI

struct FavoriteList: View {
    @Bindable var viewModel: CharacterListViewModel
    
    var body: some View {
        List {
            Text("Favorites")
                .font(.largeTitle)
                .bold()
            ForEach(viewModel.characters, id:\.id) { character in
                if viewModel.isFavoriteCharacter(id: character.id) {
                    CharacterListRow(character: character, isFavoriteCharacter: true) {
                        toggleFavorite(id: character.id)
                    }
                }
            }
        }
        .onAppear {
            handleOnAppear()
        }
    }
    
    
    private func handleOnAppear() {
        if !viewModel.isLoading {
            Task {
                await viewModel.fetchMissingFavoriteCharacters()
            }
        }
    }
    
    private func toggleFavorite(id: Int) {
        viewModel.toggleFavorite(id: id)
    }
}

//#Preview {
//    FavoriteList()
//}
