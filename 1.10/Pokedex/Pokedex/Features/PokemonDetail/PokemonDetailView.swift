//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by ali cihan on 18.09.2025.
//

import SwiftUI

struct PokemonDetailView: View {
    let name: String
    @State var viewModel = PokemonDetailViewModel()
    
    var body: some View {
        Form {
            if let pokemon = viewModel.pokemon {
                
                Section("Info"){
                    HStack {
                        AsyncImage(url: URL(string: pokemon.sprites.frontDefault!)) { result in
                            switch result {
                            case .empty:
                                Image(systemName: "pawprint.fill")
                            case .success(let image):
                                image.resizable().scaledToFit()
                            case .failure(let error):
                                Image(systemName: "exclamationmark.square")
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("ID: \(pokemon.id)")
                            Text("Name: \(pokemon.name.uppercased())")
                            Text("Type: \(self.viewModel.types)")
                        }
                        
                    }
                }
                Section("Abilities") {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(pokemon.abilities, id:\.slot) { ability in
                            Text(ability.ability.name.capitalized)
                        }
                    }
                }
                
            }
        }
        .onAppear {
            requestFetchPokemon()
        }
    }
    
    func requestFetchPokemon() {
        Task {
            await viewModel.fetchPokemonData(queryString: name)
        }
        
    }
}

#Preview {
    PokemonDetailView(name: "pikachu")
}
