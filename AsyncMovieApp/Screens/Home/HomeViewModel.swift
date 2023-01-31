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
    
    @Published private(set) var topRatedMovies: ServiceModel?
    private let service: MoviesServiceable
    var filteredData = [Results]()
    var showingAlert: Bool = false
    var movieTypes: [MovieType] = [.movie,.people,.tv]
    var lastContent:Int {
        return topRatedMovies?.results?.last?.id ?? 0
    }
    
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
        guard let data = topRatedMovies?.results else { return }
        filteredData = data.filter {
            (($0.title ?? $0.name) ?? "").contains(searchTerm)
        }
    }
    
    func changeStateToReady() {
        topRatedMovies = nil
        changeState(.ready)
    }
    
    func loadMoreContent(movieModel:Results, movieType: MovieType) {
        if movieModel.id ==  lastContent  && topRatedMovies?.page != topRatedMovies?.totalPages {
            fetchMovies(page: (topRatedMovies?.page ?? 1) + 1, movieType: movieType)
        }
    }
    
    func appendItems(items: ServiceModel) {
        if topRatedMovies?.results == nil {
            topRatedMovies = items
            topRatedMovies?.results = items.results?.filter {
                $0.overview != ""
            }
        } else {
            guard var result = topRatedMovies?.results,
                  let contents = items.results else { return }
            topRatedMovies?.totalPages = items.totalPages
            topRatedMovies?.page = items.page
            topRatedMovies?.totalResults = items.totalResults
            result.append(contentsOf: contents)
            result = result.filter {
                $0.overview != ""
            }
            topRatedMovies?.results = result
        }
    }
    
    func fetchMovies(page:Int, movieType: MovieType) {
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
