//
//  AddMovie.swift
//  MasterListApp
//
//  Created by ali cihan on 1.09.2025.
//

import SwiftUI

struct AddMovie: View {
    @Environment(\.dismiss) var dismiss
    @Binding var movies: [Movie]
    @State var title: String = ""
    @State var rating: String = ""
    @State var userWatched: Bool = false
    
    var body: some View {
        VStack {
            TextField("Title", text: $title)
            TextField("Rating", text: $rating)
            Toggle("Did you watch?", isOn: $userWatched)
            Button("Add movie") {
                addMovie()
                dismiss()
            }
        }
        .padding()
        
    }
    
    func addMovie() {
        if title == ""{
            return
        }
        let movie = Movie(
            rank: 9999,
            title: title,
            description: "",
            image: "",
            bigImage: "",
            genre: [],
            thumbnail: "",
            rating: rating,
            id: UUID().uuidString,
            year: 9999,
            imdbID: "",
            imdbLink: "",
            userWatched: false
        )
        movies.append(movie)
    }
}
