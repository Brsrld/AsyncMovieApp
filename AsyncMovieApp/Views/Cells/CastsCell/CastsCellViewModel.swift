//
//  CastsCellViewModel.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 1.02.2023.
//

import Foundation

final class CastsCellViewModel {
    
    var content: Cast
    
    var imageUrl: URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = MoviesEndpoint.image(imagePath: content.profilePath ?? "").scheme
        urlComponents.host = MoviesEndpoint.image(imagePath: content.profilePath ?? "").imageHost
        urlComponents.path = MoviesEndpoint.image(imagePath: content.profilePath ?? "").path
        urlComponents.query = MoviesEndpoint.image(imagePath: content.profilePath ?? "").query
        
        guard let url = urlComponents.url else {
            return .applicationDirectory
        }
        return url
    }
    
    var name: String {
        return content.name ?? ""
    }
    
    
    init(content: Cast) {
        self.content = content
    }
}
