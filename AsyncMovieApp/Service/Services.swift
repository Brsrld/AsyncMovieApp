//
//  Services.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 29.01.2023.
//

import Foundation
import SwiftUI

protocol MoviesServiceable {
    func getTopRated(page: Int) async -> Result<TopRatedModel, RequestError>
    func getMovieDetail(id: Int) async -> Result<MovieModel, RequestError>
}

struct MoviesService: HTTPClient, MoviesServiceable {
    func getTopRated(page: Int) async -> Result<TopRatedModel, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.topRated(page: page), responseModel: TopRatedModel.self)
    }
    
    func getMovieDetail(id: Int) async -> Result<MovieModel, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.movieDetail(id: id), responseModel: MovieModel.self)
    }
}
