//
//  Movie.swift
//  MasterListApp
//
//  Created by ali cihan on 1.09.2025.
//

import Foundation

struct Movie: Codable, Identifiable {
    let rank: Int
    let title: String
    let description: String
    let image: String
    let bigImage: String
    let genre: [String]
    let thumbnail: String
    let rating: String
    let id: String
    let year: Int
    let imdbID: String
    let imdbLink: String
    var userWatched: Bool = false

    enum CodingKeys: String, CodingKey {
        case rank
        case title
        case description
        case image
        case bigImage = "big_image"
        case genre
        case thumbnail
        case rating
        case id
        case year
        case imdbID = "imdbid"
        case imdbLink = "imdb_link"
    }
}
