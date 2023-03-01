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
    @Published private(set) var personMovieCredits: PeopleCredits?
    @Published private(set) var personTVCredits: PeopleCredits?
    @Published private(set) var tvDetail: TVDetailsModel?
    @Published private(set) var personDetail: PeopleDetailsModel?
    
    private let service: MoviesServiceable
    let id: Int?
    let type: MovieType
    var showingAlert: Bool = false
    var imageUrl: URL?
   
    
    init(id:Int?, type:MovieType) {
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
        
        guard let url = urlComponents.url else { return }
        self.imageUrl = url
    }
    
    func generateURL(imageUrl: String?) -> URL {
        guard let url = imageUrl else { return .applicationDirectory}
        var urlComponents = URLComponents()
        urlComponents.scheme = MoviesEndpoint.image(imagePath: url).scheme
        urlComponents.host = MoviesEndpoint.image(imagePath: url).imageHost
        urlComponents.path = MoviesEndpoint.image(imagePath: url).path
        
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
            fetchPersonMovieCredits()
            fetchPersonTvCredits()
        }
    }
    
    private func fetchTvDetails() {
        guard let id = id else { return }
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
        guard let id = id else { return }
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
        guard let id = id else { return }
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
        guard let id = id else { return }
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
    
    private func fetchPersonDetail() {
        guard let id = id else { return }
        self.changeState(.loading)
        Task(priority: .background) { [weak self] in
            let result = await service.getPersonDetail(id: id)
            
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
    
    private func fetchPersonTvCredits() {
        guard let id = id else { return }
        self.changeState(.loading)
        Task(priority: .background) { [weak self] in
            let result = await service.personTvCredits(id: id)
            
            self?.changeState(.finished)
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    self?.personTVCredits = data
                }
            case .failure(let error):
                self?.changeState(.error(error: error.localizedDescription))
                self?.showingAlert = true
            }
        }
    }
    
    private func fetchPersonMovieCredits() {
        guard let id = id else { return }
        self.changeState(.loading)
        Task(priority: .background) { [weak self] in
            let result = await service.personMovieCredits(id: id)
            
            self?.changeState(.finished)
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    self?.personMovieCredits = data
                }
            case .failure(let error):
                self?.changeState(.error(error: error.localizedDescription))
                self?.showingAlert = true
            }
        }
    }
}
