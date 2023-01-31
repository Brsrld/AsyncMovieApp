//
//  HomeCellViewModel.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 30.01.2023.
//

import SwiftUI

final class HomeCellViewModel: ObservableObject {
    
    var content: Results
    var imageUrl: URL {
        if let posterPath = content.posterPath {
            guard let url =  URL(string: MoviesEndpoint.image(imagePath: posterPath).path) else { return .applicationDirectory}
            return url
        } else {
            guard let url =  URL(string: MoviesEndpoint.image(imagePath: content.profilePath ?? "").path) else { return .applicationDirectory}
            return url
        }
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
