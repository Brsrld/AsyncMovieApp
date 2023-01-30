//
//  HomeCellViewModel.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 30.01.2023.
//

import SwiftUI

final class HomeCellViewModel: ObservableObject {
    
    var content: MovieModel
    var imageUrl: URL {
        guard let url =  URL(string: MoviesEndpoint.image(imagePath: content.posterPath).path) else { return URL.applicationDirectory}
        return url
    }
    
    init(content: MovieModel) {
        self.content = content
    }
}
