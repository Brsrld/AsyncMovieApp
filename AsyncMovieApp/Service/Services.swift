//
//  Services.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 29.01.2023.
//

import Foundation
import SwiftUI

protocol MoviesServiceable {
    func getTV(page: Int) async -> Result<ServiceModel, RequestError>
    func getMovie(page: Int) async -> Result<ServiceModel, RequestError>
    func getPeople(page: Int) async -> Result<ServiceModel, RequestError>
    func getDetail(id: Int) async -> Result<Results, RequestError>
    func getPersonDetail(id: Int) async -> Result<PeopleDetailsModel, RequestError>
}

struct MoviesService: HTTPClient, MoviesServiceable {
    func getMovie(page: Int) async -> Result<ServiceModel, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.movie(page: page), responseModel: ServiceModel.self)
    }
    
    func getPeople(page: Int) async -> Result<ServiceModel, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.people(page: page), responseModel: ServiceModel.self)
    }
    
    func getTV(page: Int) async -> Result<ServiceModel, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.tv(page: page), responseModel: ServiceModel.self)
    }
    
    func getDetail(id: Int) async -> Result<Results, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.movieDetail(id: id), responseModel: Results.self)
    }
    
    func getPersonDetail(id: Int) async -> Result<PeopleDetailsModel, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.person(id: id), responseModel: PeopleDetailsModel.self)
    }
}
