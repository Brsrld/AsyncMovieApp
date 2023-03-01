//
//  PeopleCredits.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 5.02.2023.
//

import Foundation

// MARK: - PeopleCredits
struct PeopleCredits: Codable {
    let cast, crew: [PeopleCredit]?
    let id: Int?
}

// MARK: - Cast
struct PeopleCredit: Codable {
    let character, creditID, releaseDate: String?
    let voteCount: Int?
    let video, adult: Bool?
    let voteAverage: Double?
    let title: String?
    let genreIDS: [Int]?
    let originalLanguage: String?
    let originalTitle: String?
    let popularity: Double?
    let id: Int?
    let backdropPath: String?
    let overview: String?
    let posterPath: String?
    let department: String?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case character
        case creditID = "credit_id"
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case video, adult
        case voteAverage = "vote_average"
        case title
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case popularity, id
        case backdropPath = "backdrop_path"
        case overview
        case posterPath = "poster_path"
        case department, job
    }
}
