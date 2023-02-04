//
//  HomeCellViewModel.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 30.01.2023.
//

import SwiftUI

final class HomeCellViewModel {
    
    private(set) var title: String
    private(set) var overView: String
    private(set) var imageURL: String
    
    func prepareImageURL() -> URL {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = MoviesEndpoint.image(imagePath: imageURL).scheme
        urlComponents.host = MoviesEndpoint.image(imagePath: imageURL).imageHost
        urlComponents.path = MoviesEndpoint.image(imagePath: imageURL).path
        urlComponents.query = MoviesEndpoint.image(imagePath: imageURL).query
        
        guard let url = urlComponents.url else {
            return .applicationDirectory
        }
        return url
    }
    
    init(title:String, overView:String, imageURL: String) {
        self.imageURL = imageURL
        self.overView = overView
        self.title = title
    }
}
