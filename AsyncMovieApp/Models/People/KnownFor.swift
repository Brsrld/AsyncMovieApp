//
//  KnownFor.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 4.02.2023.
//

import Foundation

// MARK: - KnownFor
struct KnownFor: Codable {
    let posterPath: String?
    let adult: Bool?
    let overview, releaseDate, originalTitle: String?
    let genreIDS: [Int]?
    let id: Int?
    let mediaType: String?
    let originalLanguage: String?
    let title, backdropPath: String?
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let voteAverage: Double?
    let firstAirDate: String?
    let originCountry: [String]?
    let name, originalName: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult, overview
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case id
        case mediaType = "media_type"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case name
        case originalName = "original_name"
    }
}
