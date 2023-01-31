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
    var showingAlert: Bool = false
    
    private let service: MoviesServiceable
    var filteredData = [MovieModel]()
    
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
        guard let page = topRatedMovies?.page else { return }
        if movieModel.id == topRatedMovies?.results.last?.id && topRatedMovies?.page != topRatedMovies?.totalPages {
            fetchMovies(page: page + 1)
           }
       }
    
    func appendItems(items: TopRatedModel) {
        topRatedMovies?.totalPages = items.totalPages
        topRatedMovies?.page = items.page
        topRatedMovies?.totalResults = items.totalResults
        topRatedMovies?.results.append(contentsOf: items.results)
    }
    
    func fetchMovies(page:Int) {
        self.changeState(.loading)
        Task(priority: .background) { [weak self] in
            let result = await service.getTopRated()
            self?.changeState(.finished)
            switch result {
            case .success(let topRated):
                DispatchQueue.main.async { [weak self] in
                    self?.topRatedMovies = topRated
                    if topRated.page != 1 {
                        self?.appendItems(items: topRated)
                    }
                }
            case .failure(let error):
                self?.changeState(.error(error: error.localizedDescription))
                self?.showingAlert = true
            }
        }
    }
}
