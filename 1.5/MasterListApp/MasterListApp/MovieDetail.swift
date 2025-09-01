//
//  MovieDetail.swift
//  MasterListApp
//
//  Created by ali cihan on 1.09.2025.
//

import SwiftUI

struct MovieDetail: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "film")
                    .font(.largeTitle)
                Text(movie.title)
                    .bold()
                    .font(.largeTitle)
                    .lineLimit(2)
            }
            HStack {
                Text("Genre :")
                    .bold()
                Text(movie.genre.joined(separator: ","))
            }
            HStack {
                Text("Rating :")
                    .bold()
                Text(movie.rating)
                Spacer()
                Text("Year :")
                    .bold()
                Text(String(format: "%.4d", movie.year))
            }
            Text(movie.description)
            AsyncImage(url: URL(string: movie.image))
                .mask {
                    RoundedRectangle(cornerRadius: 25)
                }
        }
        .padding()
    }
}

#Preview {
    let ikiru = Movie(
        rank: 97,
        title: "Ikiru",
        description: "A bureaucrat tries to find meaning in his life after he discovers he has terminal cancer.",
        image: "https://m.media-amazon.com/images/M/MV5BYWM1YmZkNTctZDAwNy00ZTY4LWFjMTktYzU4ZjViMmU1OTJmXkEyXkFqcGdeQXVyMTA0MTM5NjI2._V1_QL75_UX380_CR0,4,380,562_.jpg",
        bigImage: "https://m.media-amazon.com/images/M/MV5BYWM1YmZkNTctZDAwNy00ZTY4LWFjMTktYzU4ZjViMmU1OTJmXkEyXkFqcGdeQXVyMTA0MTM5NjI2._V1_QL75_UX380_CR0,4,380,562_.jpg",
        genre: ["Drama"],
        thumbnail: "https://m.media-amazon.com/images/M/MV5BYWM1YmZkNTctZDAwNy00ZTY4LWFjMTktYzU4ZjViMmU1OTJmXkEyXkFqcGdeQXVyMTA0MTM5NjI2._V1_UY67_CR0,0,45,67_AL_.jpg",
        rating: "8.3",
        id: "top97",
        year: 1952,
        imdbID: "tt0044741",
        imdbLink: "https://www.imdb.com/title/tt0044741",
        userWatched: false
    )
    MovieDetail(movie: ikiru)
}
