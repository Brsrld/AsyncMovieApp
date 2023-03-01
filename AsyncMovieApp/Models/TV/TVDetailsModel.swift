//
//  TVDetailsModel.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 1.02.2023.
//

import Foundation

// MARK: - TVDetailsModel
struct TVDetailsModel: Codable {
    let backdropPath: String?
    let homepage: String?
    let id: Int?
    let name: String?
    let originalLanguage, originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case homepage, id
        case name
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
