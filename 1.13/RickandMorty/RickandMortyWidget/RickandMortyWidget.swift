//
//  RickandMortyWidget.swift
//  RickandMortyWidget
//
//  Created by ali cihan on 17.10.2025.
//

import WidgetKit
import SwiftUI
import AppIntents

struct RickandMortyWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            Color.clear
            VStack {
                Text(entry.date.formatted(.dateTime.weekday(.wide)))
                    .bold()
                    .font(.headline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                Text(entry.date, style: .time)
                    .bold()
                    .font(.largeTitle)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                Text(entry.name)
            }
            .padding()
            .background {
                Color.gray.opacity(0.8).clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(intent: SwitchCharacterIntent()) {
                        Image(systemName: "arrow.clockwise")
                    }
                    .font(.caption)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.white.opacity(0.2))
                    .cornerRadius(8)
                    .buttonStyle(.plain)
                }
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    var imageView: some View {
        if let data = entry.imageData,
        let image = UIImage(data: data) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .opacity(0.8)
        } else {
            LinearGradient(colors: [.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
                .opacity(0.8)
        }
    }
}

struct RickandMortyWidget: Widget {
    let kind: String = "RickandMortyWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            RickandMortyWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    imageView(entry: entry)
                }
        }
        .configurationDisplayName("Rick & Morty Calender")
        .description("Rick & Morty Calender")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
    
    @ViewBuilder
    func imageView(entry: RMCharacterEntry) -> some View {
        if let data = entry.imageData,
        let image = UIImage(data: data) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .opacity(0.8)
        } else {
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .opacity(0.8)
        }
    }
}

#Preview(as: .systemLarge) {
    RickandMortyWidget()
} timeline: {
    RMCharacterEntry(date: .now, name: "Rick", image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")
}
