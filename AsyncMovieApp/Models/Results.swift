//
//  MovieModel.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 29.01.2023.
//

import Foundation

// MARK: - Movie
struct Results: Codable {
    let adult: Bool?
    let knownFor: [Results]?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    var overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let name: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case overview
        case popularity
        case id
        case title
        case video
        case name
        case knownFor = "known_for"
        case profilePath = "profile_path"
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
