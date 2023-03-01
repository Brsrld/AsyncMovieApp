//
//  HomeViewModel.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 29.01.2023.
//

import Foundation
import SwiftUI

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

final class HomeViewModel: BaseViewModel<HomeViewStates> {
    
    @Published private(set) var serviceContents: ServiceModel?
    @Published private(set) var filteredData = [ModelResults]()
    
    private(set) var movieTypes: [MovieType] = [.movie,.people,.tv]
    private let service: MoviesServiceable
    var showingAlert: Bool = false
    var movieType: MovieType = .movie
   
    override init() {
        self.service = MoviesService()
    }
    
    func search(searchTerm: String) {
        defer {
            if searchTerm == "" {
                changeState(.finished)
            } else {
                changeState(.searching)
            }
        }
        guard let data = serviceContents?.results else { return }
        filteredData = data.filter {
            (($0.title ?? $0.name) ?? "").contains(searchTerm)
        }
    }
    
    func changeStateToReady() {
        serviceContents = nil
        changeState(.ready)
    }
    
    func generateURL(imageUrl: String?) -> URL {
        guard let url = imageUrl else { return .applicationDirectory }
        var urlComponents = URLComponents()
        urlComponents.scheme = MoviesEndpoint.image(imagePath: url).scheme
        urlComponents.host = MoviesEndpoint.image(imagePath: url).imageHost
        urlComponents.path = MoviesEndpoint.image(imagePath: url).path
        
        guard let url = urlComponents.url else {
            return .applicationDirectory
        }
        return url
    }
    
    func loadMoreContent(movieModel:ModelResults) {
        guard let lastId = serviceContents?.results?.last?.id else { return }
        if movieModel.id ==  lastId  && serviceContents?.page != serviceContents?.totalPages {
            fetchMovies(page: (serviceContents?.page ?? 1) + 1)
        }
    }
    
    func appendItems(items: ServiceModel) {
        if serviceContents?.results == nil {
            serviceContents = items
            serviceContents?.results = items.results?.filter {
                $0.overview != ""
            }
        } else {
            guard var result = serviceContents?.results,
                  let contents = items.results else { return }
            serviceContents?.totalPages = items.totalPages
            serviceContents?.page = items.page
            serviceContents?.totalResults = items.totalResults
            result.append(contentsOf: contents)
            result = result.filter {
                $0.overview != ""
            }
            serviceContents?.results = result
        }
    }
    
    func fetchMovies(page:Int) {
        if page == 1 {
            self.changeState(.loading)
        }
        
        Task(priority: .background) { [weak self] in
            var result: Result<ServiceModel, RequestError>
            switch movieType {
            case .tv:
                result = await service.getTV(page: page)
            case .movie:
                result = await service.getMovie(page: page)
            case .people:
                result = await service.getPeople(page: page)
            }
            
            self?.changeState(.finished)
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    self?.appendItems(items: data)
                }
            case .failure(let error):
                self?.changeState(.error(error: error.localizedDescription))
                self?.showingAlert = true
            }
        }
    }
}
