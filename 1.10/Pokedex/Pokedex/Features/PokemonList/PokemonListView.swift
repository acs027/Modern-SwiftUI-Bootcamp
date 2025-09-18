//
//  PokemonListView.swift
//  Pokedex
//
//  Created by ali cihan on 18.09.2025.
//

import SwiftUI

struct PokemonListView: View {
    @State private var viewModel = PokemonListViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.pokemonList, id:\.id) { pokemon in
                        NavigationLink {
                            PokemonDetailView(name: pokemon.name)
                        }
                        label: {
                            rowView(pokemon: pokemon)
                        }
                    }
                }
            }
            .searchable(text: $viewModel.filterText)
            .searchSuggestions({
                ForEach(viewModel.getSuggestion(), id:\.id) { suggestion in
                    Text(suggestion.name.capitalized)
                        .searchCompletion(suggestion.name)
                }
            })
            .onSubmit(of: .search, {
                viewModel.addPokemon()
            })
            .padding(.horizontal)
            .navigationTitle("Pokemons")
        }
        .onAppear {
            requestPokemonListFetch()
        }
    }
    
    private func rowView(pokemon: PokemonListItem) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 3)
            .background(.ultraThinMaterial)
            .frame(height: 100)
            .overlay {
                HStack {
                    Text("\(pokemon.id)")
                        .bold()
                        .font(.title)
                    Text(pokemon.name.capitalized)
                        .bold()
                        .font(.title)
                    Spacer()
                    AsyncImage(url: URL(string: viewModel.getImageUrlString(pokemonID: pokemon.id))) { result in
                        result.image?
                            .resizable()
                        .scaledToFit()}
                }
                
                .padding()
            }
            .onAppear {
                if pokemon.id == viewModel.pokemonList.last?.id,
                   !viewModel.isLoading
                {
                    loadMore()
                }
            }
    }
    
    private func requestPokemonListFetch() {
        if viewModel.pokemonList.isEmpty {
            Task {
                await viewModel.fetchPokemons()
            }
        }
    }
    
    private func loadMore() {
        Task {
            await viewModel.loadMore()
        }
    }
}

#Preview {
    PokemonListView()
}
