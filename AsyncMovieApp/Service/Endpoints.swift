//
//  Endpoint.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 29.01.2023.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.themoviedb.org"
    }
}

enum MoviesEndpoint {
    case topRated
    case movieDetail(id: Int)
    case image(imagePath:String)
}

extension MoviesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .topRated:
            return "/3/movie/top_rated"
        case .movieDetail(let id):
            return "/3/movie/\(id)"
        case .image(let imagePath):
            return "https://image.tmdb.org/t/p/w500\(imagePath)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .topRated, .movieDetail, .image:
            return .get
        }
    }

    var header: [String: String]? {
        // Access Token to use in Bearer header
        let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZTAyZjg5OWQyZjhmNjdlZGMxNjYyZmFmZmVkM2Y0MSIsInN1YiI6IjYwOTMxODIyZmQ2ZmExMDA1ODU1MmYwNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.fVP-A30256wyYzFw8HaFtkR6XQjDZ0Iqh-DElU_C2R8"
        switch self {
        case .topRated, .movieDetail, .image:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .topRated, .movieDetail, .image:
            return nil
        }
    }
}
