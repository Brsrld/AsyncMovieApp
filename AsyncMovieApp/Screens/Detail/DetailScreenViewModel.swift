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
    @Published private(set) var personDetail: PeopleDetailsModel?
    
    private let service: MoviesServiceable
    var content: ModelResults
    var showingAlert: Bool = false
    var imageUrl: URL?
    var type: MovieType
    
    init(content:ModelResults, type:MovieType) {
        self.content = content
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
    
    func generateURL(imageUrl: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = MoviesEndpoint.image(imagePath: imageUrl).scheme
        urlComponents.host = MoviesEndpoint.image(imagePath: imageUrl).imageHost
        urlComponents.path = MoviesEndpoint.image(imagePath: imageUrl).path
        urlComponents.query = MoviesEndpoint.image(imagePath: imageUrl).query
        
        guard let url = urlComponents.url else {
            return .applicationDirectory
        }
        return url
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
            fetchPersonDetail()
        }
    }
    
    private func fetchTvDetails() {
        self.changeState(.loading)
        Task(priority: .background) { [weak self] in
            let result = await service.getTVDetails(id: content.id ?? 0)
            
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
            let result = await service.getTVCredits(id: content.id ?? 0)
            
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
            let result = await service.getDetail(id: content.id ?? 0)
            
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
            let result = await service.getMovieCredits(id: content.id ?? 0)
            
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
    
    private func fetchPersonDetail() {
        self.changeState(.loading)
        Task(priority: .background) { [weak self] in
            let result = await service.getPersonDetail(id: content.id ?? 0)
            
            self?.changeState(.finished)
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    self?.personDetail = data
                    self?.prepareUrl(url: data.profilePath ?? "")
                }
            case .failure(let error):
                self?.changeState(.error(error: error.localizedDescription))
                self?.showingAlert = true
            }
        }
    }
}
