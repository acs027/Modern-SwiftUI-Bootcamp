//
//  FavoriteList.swift
//  RickandMorty
//
//  Created by ali cihan on 26.09.2025.
//

import SwiftUI
import SwiftData
import ActivityKit

struct FavoriteList: View {
    @Bindable var viewModel: CharacterListViewModel
    @Environment(\.modelContext) var context
    @Query var favoriteCharacters: [FavoriteCharacter]
    @State private var currentActivity: Activity<CharacterActivityAttributes>?
    
    var body: some View {
        List {
            Button("LiveActivity") {
                handleActivity()
            }
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
    
    private func handleActivity() {
        if currentActivity != nil {
            stopLiveActivity()
        } else {
            startLiveActivity()
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
        viewModel.toggleFavorite(id: id, context: context)
    }
    
    private func startLiveActivity() {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            return
        }
        
        Task {
            do {
                print("1")
                let attributes = CharacterActivityAttributes()
                print("2")
                guard let state = viewModel.getRandomFavoriteCharacterAsAttributesContentState() else { return }
                print("3")
                let activity = try Activity.request(attributes: attributes, content: .init(state: state, staleDate: nil), pushType: nil)
                print("4")
                currentActivity = activity
                print("acstivity here ")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func stopLiveActivity() {
        guard let activity = currentActivity else { return }
        Task {
            await activity.end(nil, dismissalPolicy: .immediate)
            currentActivity = nil
        }
    }
    
    
    private func updateLiveActivity() {
        guard let activity = currentActivity  else { return }
        
        Task {
            guard let updatedState = await viewModel.getRandomFavoriteCharacterAsAttributesContentState() else { return }
            await activity.update(.init(state: updatedState, staleDate: nil))
            currentActivity = nil
        }
    }
}

//#Preview {
//    FavoriteList()
//}
