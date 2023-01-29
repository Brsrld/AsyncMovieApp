//
//  Services.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 29.01.2023.
//

import Foundation

protocol MoviesServiceable {
    func getTopRated() async -> Result<TopRatedModel, RequestError>
    func getMovieDetail(id: Int) async -> Result<MovieModel, RequestError>
}

struct MoviesService: MoviesServiceable {
    func getTopRated() async -> Result<TopRatedModel, RequestError> {
        return await HTTPClient.shared.sendRequest(endpoint: MoviesEndpoint.topRated, responseModel: TopRatedModel.self)
    }
    
    func getMovieDetail(id: Int) async -> Result<MovieModel, RequestError> {
        return await  HTTPClient.shared.sendRequest(endpoint: MoviesEndpoint.movieDetail(id: id), responseModel: MovieModel.self)
    }
}
