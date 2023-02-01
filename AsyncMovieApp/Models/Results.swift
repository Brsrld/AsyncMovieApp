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
    
    init(adult: Bool? = nil, knownFor: [Results]? = nil, backdropPath: String? = nil, genreIDS: [Int]? = nil, id: Int? = nil, originalLanguage: String? = nil, originalTitle: String? = nil, overview: String? = "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.", popularity: Double? = nil, posterPath: String? = nil, releaseDate: String? = nil, title: String? = "Raya and The Last Dragon", name: String? = "Icardi Fernandes", video: Bool? = nil, voteAverage: Double? = nil, voteCount: Int? = nil, profilePath: String? = nil) {
        self.adult = adult
        self.knownFor = knownFor
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.name = name
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.profilePath = profilePath
    }
}
