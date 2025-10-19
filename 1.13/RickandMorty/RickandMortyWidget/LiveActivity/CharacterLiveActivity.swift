//
//  CharacterLiveActivity.swift
//  RickandMorty
//
//  Created by ali cihan on 18.10.2025.
//

import SwiftUI
import ActivityKit
import WidgetKit

struct CharacterLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: CharacterActivityAttributes.self) { context in
            lockScreenView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    expandedLeading(context: context)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    expandedTrailing(context: context)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    expandedBottom(context: context)
                }

            } compactLeading: {
                Image(systemName: "star")
                    .font(.caption2)
            } compactTrailing: {
                Text(context.state.date, style: .time)
                    .font(.caption)
            } minimal: {
                Image(systemName: "star")
            }

        }

    }
    
    private func lockScreenView(context: ActivityViewContext<CharacterActivityAttributes>) -> some View {
        ZStack(alignment: .trailing) {
            imageView(entry: context.state)
            HStack {
                Text(context.state.date.formatted(.dateTime.weekday(.wide)))
                    .bold()
                    .font(.headline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                Text(context.state.date, style: .time)
                    .bold()
                    .font(.largeTitle)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .padding()
            .background {
                Color.gray.opacity(0.8).clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }
    
    private func expandedLeading(context: ActivityViewContext<CharacterActivityAttributes>) -> some View {
        VStack {
            Text(context.state.date.formatted(.dateTime.weekday(.wide)))
                    .bold()
                    .font(.headline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
        }
    }
    
    private func expandedTrailing(context: ActivityViewContext<CharacterActivityAttributes>) -> some View {
        ZStack {
            Color.clear
            imageView(entry: context.state)
        }
    }
    
    private func expandedBottom(context: ActivityViewContext<CharacterActivityAttributes>) -> some View {
        VStack {
            Text(context.state.date, style: .time)
                    .bold()
                    .font(.largeTitle)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
        }
    }
    
    @ViewBuilder
    private func imageView(entry: CharacterActivityAttributes.ContentState) -> some View {
//        if let data = entry.imageData,
//        let image = UIImage(data: data) {
//            Image(uiImage: image)
//                .resizable()
//                .scaledToFit()
//                .opacity(0.8)
//        } else {
//            Color.clear
//        }
        AsyncImage(url: URL(string: entry.image)) { image in
            image.resizable().scaledToFill()
        } placeholder: {
            LinearGradient(colors: [.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}


#Preview("Lock Screen", as: .content, using: CharacterActivityAttributes()) {
    CharacterLiveActivity()
} contentStates: {
    CharacterActivityAttributes.ContentState.init(date: .now, name: "Acs", image: "acs")
}

#Preview("Dynamic Island Compact", as: .dynamicIsland(.compact), using: CharacterActivityAttributes()) {
    CharacterLiveActivity()
} contentStates: {
    CharacterActivityAttributes.ContentState.init(date: .now, name: "Acs", image: "acs")
}

#Preview("Dynamic Expanded", as: .dynamicIsland(.expanded), using: CharacterActivityAttributes()) {
    CharacterLiveActivity()
} contentStates: {
    CharacterActivityAttributes.ContentState.init(date: .now, name: "Acs", image: "acs")
}
