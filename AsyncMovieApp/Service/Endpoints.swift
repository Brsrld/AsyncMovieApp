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
    var imageHost: String { get}
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var query: String { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.themoviedb.org"
    }
    
    var imageHost: String {
        return "image.tmdb.org"
    }
}

enum MoviesEndpoint {
    case movie(page: Int)
    case movieDetail(id: Int)
    case movieCredits(id: Int)
    case tv(page: Int)
    case tvDetails(id:Int)
    case tvCredits(id:Int)
    case people(page: Int)
    case person(id: Int)
    case personTvCredits(id: Int)
    case personMovieCredits(id: Int)
    case image(imagePath:String)
  
}

extension MoviesEndpoint: Endpoint {
    var query: String {
        switch self {
        case .movie(let page), .tv(let page), .people(let page):
            return "page=\(page)"
        case .movieDetail, .person, .image, .movieCredits, .tvDetails, .tvCredits, .personTvCredits, .personMovieCredits:
            return ""
        }
    }
    
    var path: String {
        switch self {
        case .movie:
            return "/3/movie/popular"
        case .movieDetail(let id):
            return "/3/movie/\(id)"
        case .person(let id):
            return "/3/person/\(id)"
        case .image(let imagePath):
            return "/t/p/w500\(imagePath)"
        case .tv:
            return "/3/tv/popular"
        case .people:
            return "/3/person/popular"
        case .movieCredits(let id):
            return "/3/movie/\(id)/credits"
        case .tvDetails(let id):
            return "/3/tv/\(id)"
        case .tvCredits(let id):
            return "/3/tv/\(id)/credits"
        case .personMovieCredits(let id):
            return "/3/person/\(id)/movie_credits"
        case .personTvCredits(let id):
            return "/3/person/\(id)/tv_credits"
        }
    }

    var method: RequestMethod {
        switch self {
        case .movie, .movieDetail, .image, .tv, .people, .person, .movieCredits, .tvDetails, .tvCredits, .personTvCredits, .personMovieCredits:
            return .get
        }
    }

    var header: [String: String]? {
        // Access Token to use in Bearer header
        let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZTAyZjg5OWQyZjhmNjdlZGMxNjYyZmFmZmVkM2Y0MSIsInN1YiI6IjYwOTMxODIyZmQ2ZmExMDA1ODU1MmYwNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.fVP-A30256wyYzFw8HaFtkR6XQjDZ0Iqh-DElU_C2R8"
        switch self {
        case .movie, .movieDetail, .image, .tv, .people, .person, .movieCredits, .tvDetails, .tvCredits, .personTvCredits, .personMovieCredits:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .movie, .movieDetail, .image, .tv, .people, .person, .movieCredits, .tvDetails, .tvCredits, .personTvCredits, .personMovieCredits:
            return nil
        }
    }
}
