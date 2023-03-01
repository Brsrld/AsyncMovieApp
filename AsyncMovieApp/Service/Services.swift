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
    func getDetail(id: Int) async -> Result<ModelResults, RequestError>
    func getPersonDetail(id: Int) async -> Result<PeopleDetailsModel, RequestError>
    func getMovieCredits(id: Int) async -> Result<CastModel, RequestError>
    func getTVDetails(id: Int) async -> Result<TVDetailsModel, RequestError>
    func getTVCredits(id: Int) async -> Result<CastModel, RequestError>
    func personTvCredits(id: Int) async -> Result<PeopleCredits, RequestError>
    func personMovieCredits(id: Int) async -> Result<PeopleCredits, RequestError>
    
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
    
    func getDetail(id: Int) async -> Result<ModelResults, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.movieDetail(id: id), responseModel: ModelResults.self)
    }
    
    func getPersonDetail(id: Int) async -> Result<PeopleDetailsModel, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.person(id: id), responseModel: PeopleDetailsModel.self)
    }
    
    func getMovieCredits(id: Int) async -> Result<CastModel, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.movieCredits(id: id), responseModel: CastModel.self)
    }
    
    func getTVDetails(id: Int) async -> Result<TVDetailsModel, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.tvDetails(id: id), responseModel: TVDetailsModel.self)
    }
    
    func getTVCredits(id: Int) async -> Result<CastModel, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.tvCredits(id: id), responseModel: CastModel.self)
    }
    
    func personMovieCredits(id: Int) async -> Result<PeopleCredits, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.personMovieCredits(id: id), responseModel: PeopleCredits.self)
    }
    
    func personTvCredits(id: Int) async -> Result<PeopleCredits, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.personTvCredits(id: id), responseModel: PeopleCredits.self)
    }
}
