//
//  TopRatedModel.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 29.01.2023.
//

import Foundation

// MARK: - TopRated
struct TopRatedModel: Codable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [MovieModel]

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
