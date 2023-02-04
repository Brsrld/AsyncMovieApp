//
//  DetailScreenViewModel.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 1.02.2023.
//

import Foundation

final class DetailScreenViewModel: BaseViewModel<DetailViewStates> {
    
    @Published private(set) var movieDetail: ModelResults?
    @Published private(set) var casts: CastModel?
    @Published private(set) var tvDetail: TVDetailsModel?
    private let service: MoviesServiceable
    var id: Int
    var showingAlert: Bool = false
    var imageUrl: URL?
    var type: MovieType
    
    init(id:Int, type:MovieType) {
        self.id = id
        self.type = type
        self.service = MoviesService()
        super.init()
        self.states = .ready
    }
    
    func prepareUrl(url:String) {
        var urlComponents = URLComponents()
        urlComponents.scheme = MoviesEndpoint.image(imagePath: url).scheme
        urlComponents.host = MoviesEndpoint.image(imagePath: url).imageHost
        urlComponents.path = MoviesEndpoint.image(imagePath: url).path
        urlComponents.query = MoviesEndpoint.image(imagePath: url).query
        
        guard let url = urlComponents.url else { return }
        self.imageUrl = url
    }
    
    func initializeService() {
        switch type {
        case .tv:
            fetchTvDetails()
            fetchTvCast()
        case .movie:
            fetchDetails()
            fetchCast()
        case .people:
            print("people")
        }
    }
    
    private func fetchTvDetails() {
        self.changeState(.loading)
        Task(priority: .background) { [weak self] in
            let result = await service.getTVDetails(id: id)
            
            self?.changeState(.finished)
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    self?.tvDetail = data
                    self?.prepareUrl(url: data.posterPath ?? "")
                }
            case .failure(let error):
                self?.changeState(.error(error: error.localizedDescription))
                self?.showingAlert = true
            }
        }
    }
    
    private func fetchTvCast() {
        self.changeState(.loading)
        Task(priority: .background) { [weak self] in
            let result = await service.getTVCredits(id: id)
            
            self?.changeState(.finished)
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    self?.casts = data
                }
            case .failure(let error):
                self?.changeState(.error(error: error.localizedDescription))
                self?.showingAlert = true
            }
        }
    }
    
    private func fetchDetails() {
        self.changeState(.loading)
        Task(priority: .background) { [weak self] in
            let result = await service.getDetail(id: id)
            
            self?.changeState(.finished)
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    self?.movieDetail = data
                    self?.prepareUrl(url: data.posterPath ?? "")
                }
            case .failure(let error):
                self?.changeState(.error(error: error.localizedDescription))
                self?.showingAlert = true
            }
        }
    }
    
    private func fetchCast() {
        self.changeState(.loading)
        Task(priority: .background) { [weak self] in
            let result = await service.getMovieCredits(id: id)
            
            self?.changeState(.finished)
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    self?.casts = data
                }
            case .failure(let error):
                self?.changeState(.error(error: error.localizedDescription))
                self?.showingAlert = true
            }
        }
    }
}
