//
//  HomeViewStates.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 29.01.2023.
//

import Foundation

enum HomeViewStates: ViewStateProtocol {
    case loading
    case finished
    case ready
    case error(error: String)
}
