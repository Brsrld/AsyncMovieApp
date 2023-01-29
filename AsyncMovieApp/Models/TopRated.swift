//
//  TopRated.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 29.01.2023.
//

import Foundation

// MARK: - TopRated
struct TopRated: Codable {
    let page: Int?
    let results: [Results]?
    let totalResults: Int?
    let totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

// MARK: - Result
struct Results: Codable {
    let posterPath: String?
    let adult: Bool?
    let overview: String?
    let releaseDate: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalTitle: String?
    let originalLanguage: OriginalLanguage?
    let title: String?
    let backdropPath: String?
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult, overview
        case releaseDate = "release_date"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case fr = "fr"
    case it = "it"
    case ja = "ja"
}
