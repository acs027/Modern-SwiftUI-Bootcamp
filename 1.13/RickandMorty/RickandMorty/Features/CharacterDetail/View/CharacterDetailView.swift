//
//  CharacterDetailView.swift
//  RickandMorty
//
//  Created by ali cihan on 24.09.2025.
//

import SwiftUI
import Kingfisher

struct CharacterDetailView: View {
    @State var viewModel: CharacterDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Hero Image
                avatarSection
                
                // Status, Species, Gender
                infoSection
                
                // Origin & Location
                originLocationSection
                
                // Episodes
                episodes
            }
            .padding()
            .background(
                .ultraThinMaterial)
        }
    }
    
    private var avatarSection: some View {
        KFImage(URL(string: viewModel.character.image))
            .resizable()
            .scaledToFill()
            .frame(height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(radius: 10)
            .overlay(alignment: .bottom) {
                Text(viewModel.character.name)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .shadow(radius: 5)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.black.opacity(0.6), .clear],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .padding(.vertical)
                    )
            }
    }
    
    private var infoSection: some View {
        HStack(spacing: 30) {
            detailLabel("Status", viewModel.character.status.rawValue, systemImage: viewModel.character.status.symbolName)
                .foregroundStyle(viewModel.character.status.rgba.color)
            detailLabel("Species", viewModel.character.species.rawValue, systemImage: viewModel.character.species.symbolName)
            detailLabel("Gender", viewModel.character.gender.rawValue, systemImage: viewModel.character.gender.symbolName)
                .foregroundStyle(viewModel.character.gender.rgba.color)
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
    }
    
    private var originLocationSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            section(title: "Origin", value: viewModel.character.origin.name, systemImage: "globe")
            section(title: "Location", value: viewModel.character.location.name, systemImage: "mappin.and.ellipse")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
    }
    
    private var episodes: some View {
        LazyVStack(alignment: .leading, spacing: 10) {
            Text("Episodes")
                .font(.title2.bold())
                .padding(.bottom, 5)
            ForEach(viewModel.character.episode, id: \.self) { episode in
                Label("Episode \(episode.split(separator: "/").last ?? "")", systemImage: "play.circle.fill")
                    .foregroundStyle(.blue)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
    }
    
    // MARK: - Helpers
    private func detailLabel(_ title: String, _ value: String, systemImage: String) -> some View {
        VStack {
            Label(value, systemImage: systemImage)
                .font(.headline)
        }
    }
    
    private func section(title: String, value: String, systemImage: String) -> some View {
        HStack {
            Image(systemName: systemImage)
                .foregroundStyle(.blue)
            VStack(alignment: .leading) {
                Text(title).font(.caption).foregroundStyle(.secondary)
                Text(value).font(.headline)
            }
        }
    }
}


#Preview {
    let character = MockDataService.fetchMockCharacter()
    CharacterDetailView(viewModel: CharacterDetailViewModel(character: character))
}
