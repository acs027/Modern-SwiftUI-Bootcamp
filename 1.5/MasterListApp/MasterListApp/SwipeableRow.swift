//
//  SwipeableRow.swift
//  MasterListApp
//
//  Created by ali cihan on 1.09.2025.
//

import SwiftUI

struct SwipeableRow<Content:View>: View {
    let movie: Movie
    let content: () -> Content
    let onDelete: () -> Void
    let onWatchToggle: () -> Void
    let navigate: () -> Void
    
    @State private var offsetX: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            // Background buttons
            HStack(spacing: 0) {
                Spacer()
                Button {
                    onWatchToggle()
                    reset()
                } label: {
                    Label(movie.userWatched ? "" : "",
                          systemImage: movie.userWatched ? "eye.slash" : "eye")
                        .frame(width: 80, height: 50)
                        .background(movie.userWatched ? Color.teal : Color.green)
                        .foregroundColor(.white)
                }
                
                Button(role: .destructive) {
                    onDelete()
                    reset()
                } label: {
                    Label("", systemImage: "trash")
                        .frame(width: 80, height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                }
            }
            .mask {
                RoundedRectangle(cornerRadius: 10)
            }
            .padding(.horizontal)
            
            // Foreground content
            content()
                .background(Color.white)
                .offset(x: offsetX)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 10, coordinateSpace: .local)
                        .onChanged { value in
                            if value.translation.width < 0 {
                                offsetX = value.translation.width
                            }
                        }
                        .onEnded { value in
                            if value.translation.width < -80 {
                                offsetX = -160 // width of both buttons
                            } else {
                                reset()
                            }
                        }
                )
                .onTapGesture {
                    navigate()
                }
                .animation(.easeOut, value: offsetX)
        }
    }
    
    private func reset() {
        offsetX = 0
    }
}
