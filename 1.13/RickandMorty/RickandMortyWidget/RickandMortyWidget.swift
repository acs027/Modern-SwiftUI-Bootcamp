//
//  RickandMortyWidget.swift
//  RickandMortyWidget
//
//  Created by ali cihan on 17.10.2025.
//

import WidgetKit
import SwiftUI

struct RickandMortyWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            Color.clear
            VStack {
                Text("Time:")
                Text(entry.date, style: .time)
                Text(entry.name)
                if entry.imageData != nil {
                    Text("image data dolu")
                }
            }
        }
        .background(
            imageView
        )
    }
    
    @ViewBuilder
    var imageView: some View {
        if let data = entry.imageData,
        let image = UIImage(data: data) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .opacity(0.3)
        } else {
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .opacity(0.3)
        }
    }
}

struct RickandMortyWidget: Widget {
    let kind: String = "RickandMortyWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            RickandMortyWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    LinearGradient(colors: [.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
                }
        }
        .configurationDisplayName("Rick & Morty Calender")
        .description("Rick & Morty Calender")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

#Preview(as: .systemSmall) {
    RickandMortyWidget()
} timeline: {
    RMCharacterEntry(date: .now, name: "Rick", image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")
}
