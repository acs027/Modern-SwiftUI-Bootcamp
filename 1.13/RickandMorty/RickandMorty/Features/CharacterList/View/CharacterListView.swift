//
//  CharacterListView.swift
//  RickandMorty
//
//  Created by ali cihan on 22.09.2025.
//

import SwiftUI

struct CharacterListView: View {
    @State var viewModel: CharacterListViewModel = CharacterListViewModel()
    @Namespace private var namespace
    @State private var isFavoriteShowing: Bool = false
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.characters, id:\.id) { character in
                        NavigationLink {
                            let characterDetailViewModel = CharacterDetailViewModel(character: character)
                            CharacterDetailView(viewModel: characterDetailViewModel)
                                .navigationTransition(.zoom(sourceID: character.id, in: namespace))
                        } label: {
                            CharacterListRow(character: character, isFavoriteCharacter: viewModel.isFavoriteCharacter(id: character.id)) {
                                toggleFavorite(id: character.id)
                            }
                            .matchedGeometryEffect(id: character.id, in: namespace)
                            .onAppear {
                                loadMore(characterID: character.id)
                            }
                        }
                    }
                }
            }
            
            .onSubmit(of: .search) {
                searchOnSubmit()
            }
            .refreshable {
                pullToRefresh()
            }
            .searchable(text: $viewModel.searchText, prompt: "Search a character")
            .navigationTitle("Characters")
            .sheet(isPresented: $isFavoriteShowing) {
                FavoriteList(viewModel: viewModel)
            }
            .toolbar {
                ToolbarItem {
                    Button("Favorites") {
                        isFavoriteShowing.toggle()
                    }
                }
            }
        }
        .onAppear {
            handleOnAppear()
        }
        .alert("Error", isPresented: $viewModel.isAlertShowing) {
            
        } message: {
            Text(viewModel.errorMessage ?? "Unknown")
        }
    }
    
    private func handleOnAppear() {
        if !viewModel.isLoading,
           viewModel.characters.isEmpty {
            Task {
                await viewModel.fetchCharacters()
            }
        }
        viewModel.loadFavorites(context: context)
    }
    
    private func loadMore(characterID: Int) {
        if viewModel.characters.last?.id == characterID, !viewModel.isLoading {
            Task {
                await viewModel.fetchCharactersPage()
            }
        }
    }
    
    private func toggleFavorite(id: Int) {
        viewModel.toggleFavorite(id: id, context: context)
    }
    
    private func searchOnSubmit() {
        if !viewModel.isLoading {
            Task {
                await viewModel.searchCharacter()
            }
        }
    }
    
    private func pullToRefresh() {
        if !viewModel.isLoading {
            Task {
                await viewModel.fetchCharacters()
            }
        }
    }
}

#Preview {
    let viewModel = CharacterListViewModel()
    viewModel.fetchCharactersFromMockData()
    return CharacterListView(viewModel: viewModel)
}
