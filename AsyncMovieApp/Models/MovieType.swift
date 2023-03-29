//
//  MovieType.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 29.03.2023.
//

import Foundation

enum MovieType {
    case tv
    case movie
    case people
    
    var title: String {
        switch self {
        case .tv:
            return "TV"
        case .movie:
            return "Movie"
        case .people:
            return "People"
        }
    }
}
