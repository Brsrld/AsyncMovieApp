//
//  HomeViewModel.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 29.01.2023.
//

import Foundation

final class HomeViewModel: BaseViewModel<HomeViewStates> {
    @Published private(set) var topRatedMovies: TopRatedModel?
    private let service: MoviesServiceable
    
    override init() {
        self.service = MoviesService()
    }
    
    func fetchMovies() {
        self.changeState(.loading)
        Task(priority: .background) { [weak self] in
            let result = await service.getTopRated()
            self?.changeState(.finished)
            switch result {
            case .success(let topRated):
                DispatchQueue.main.async { [weak self] in
                    self?.topRatedMovies = topRated
                }
            case .failure(let error):
                self?.changeState(.error(error: error.localizedDescription))
            }
        }
    }
}
