//
//  HomeCellViewModel.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 30.01.2023.
//

import SwiftUI

final class HomeCellViewModel {
    
    var content: Results
    var imageUrl: URL {
        var urlComponents = URLComponents()
        if let posterPath = content.posterPath {
            urlComponents.scheme = MoviesEndpoint.image(imagePath: posterPath).scheme
            urlComponents.host = MoviesEndpoint.image(imagePath: posterPath).imageHost
            urlComponents.path = MoviesEndpoint.image(imagePath: posterPath).path
            urlComponents.query = MoviesEndpoint.image(imagePath: posterPath).query
        } else {
            urlComponents.scheme = MoviesEndpoint.image(imagePath: content.profilePath ?? "").scheme
            urlComponents.host = MoviesEndpoint.image(imagePath: content.profilePath ?? "").imageHost
            urlComponents.path = MoviesEndpoint.image(imagePath: content.profilePath ?? "").path
            urlComponents.query = MoviesEndpoint.image(imagePath: content.profilePath ?? "").query
        }
        
        guard let url = urlComponents.url else {
            return .applicationDirectory
        }
        return url
    }
    
    var title: String {
        return content.title ?? ""
    }
    
    var name: String {
        return content.name ?? ""
    }
    
    var overView: String {
        return content.overview ?? ""
    }
    
    var knownForMovies: String {
        return content.knownFor?.first?.overview ?? ""
    }
    
    init(content: Results) {
        self.content = content
    }
}
