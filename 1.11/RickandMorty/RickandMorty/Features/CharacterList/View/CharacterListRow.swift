//
//  CharacterListRow.swift
//  RickandMorty
//
//  Created by ali cihan on 22.09.2025.
//

import SwiftUI
import Kingfisher

struct CharacterListRow: View {
    let character: RMCharacter
    let isFavoriteCharacter: Bool
    let function: () -> Void
    
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            avatar
            rowInfo
            Spacer()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial) // glassy effect
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .strokeBorder(Color.white.opacity(0.25), lineWidth: 1)
                )
        )
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
        .padding(.horizontal)
    }
    
    private var avatar: some View {
        KFImage(URL(string: character.image))
            .resizable()
            .placeholder {
                Image(systemName: "person.fill.questionmark")
                    .resizable()
                    .scaledToFit()
                    .padding(20)
                    .foregroundStyle(.gray.opacity(0.6))
            }
            .scaledToFill()
            .frame(width: 70, height: 70)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
    
    private var rowInfo: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack{
                Text(character.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Spacer()
                favoriteButton
            }
            
            HStack(spacing: 12) {
                Label(character.status.rawValue, systemImage: character.status.symbolName)
                    .foregroundStyle(character.status.rgba.color)
                    .font(.subheadline)
                
                Label(character.species.rawValue, systemImage: character.species.symbolName)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                
                Label(character.gender.rawValue, systemImage: character.gender.symbolName)
                    .foregroundStyle(character.gender.rgba.color)
                    .font(.subheadline)
            }
            .lineLimit(1)
            .minimumScaleFactor(0.8)
        }
    }
    
    @ViewBuilder
    private var favoriteButton: some View {
        Button("", systemImage: isFavoriteCharacter ? "star.fill" : "star") {
            function()
        }
        
    }
}

extension RGBA {
    var color: Color {
        Color(red: r, green: g, blue: b).opacity(a)
    }
}

//#Preview {
//    ScrollView {
//        LazyVStack(spacing: 12) {
//            CharacterListRow(character: MockDataService.fetchMockCharacter())
//            CharacterListRow(character: MockDataService.fetchMockCharacter())
//            CharacterListRow(character: MockDataService.fetchMockCharacter())
//        }
//        .padding(.vertical)
//    }
//}
