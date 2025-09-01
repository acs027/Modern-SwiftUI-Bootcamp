//
//  ContentView.swift
//  Counter
//
//  Created by ali cihan on 1.09.2025.
//

import SwiftUI

struct ContentView: View {
    @State var counter: Int = 0
    var body: some View {
        VStack {
            HStack {
                Button {
                    counter += 1
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .overlay {
                            Text("+")
                                .foregroundStyle(.black)
                                .bold()
                        }
                        .frame(height: 50)
                }
                Button {
                    counter -= 1
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .overlay {
                            Text("-")
                                .foregroundStyle(.black)
                                .bold()
                        }
                        .frame(height: 50)
                }
            }
            .padding()
            Text("Counter: \(counter)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
