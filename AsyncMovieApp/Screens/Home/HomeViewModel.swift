//
//  HomeViewModel.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 29.01.2023.
//

import Foundation
import SwiftUI

final class HomeViewModel: BaseViewModel<HomeViewStates> {
    
    @Published private(set) var topRatedMovies: TopRatedModel?
    
    private let service: MoviesServiceable
    var filteredData = [MovieModel]()
    var showingAlert: Bool = false
    var lastContent:Int {
        return topRatedMovies?.results.last?.id ?? 0
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
        filteredData = data
        filteredData = filteredData.filter {
            $0.title.lowercased().contains(searchTerm.lowercased())
        }
    }
    
    func changeStateToReady() {
        changeState(.ready)
    }
    
    func loadMoreContent(movieModel:MovieModel) {
        if movieModel.id ==  lastContent {
            fetchMovies(page: (topRatedMovies?.page ?? 1) + 1)
        }
    }
    
    func appendItems(items: TopRatedModel) {
        if topRatedMovies?.results == nil {
            topRatedMovies = items
        } else {
            topRatedMovies?.totalPages = items.totalPages
            topRatedMovies?.page = items.page
            topRatedMovies?.totalResults = items.totalResults
            topRatedMovies?.results.append(contentsOf: items.results)
        }
        
    }
    
    func fetchMovies(page:Int) {
        if page == 1 {
            self.changeState(.loading)
        }
        
        Task(priority: .background) { [weak self] in
            let result = await service.getTopRated(page: page)
            self?.changeState(.finished)
            switch result {
            case .success(let topRated):
                DispatchQueue.main.async { [weak self] in
                    self?.appendItems(items: topRated)
                }
            case .failure(let error):
                self?.changeState(.error(error: error.localizedDescription))
                self?.showingAlert = true
            }
        }
    }
}
