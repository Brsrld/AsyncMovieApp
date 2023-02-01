//
//  DetailViewStates.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 1.02.2023.
//

import Foundation

enum DetailViewStates: ViewStateProtocol {
    case loading
    case finished
    case ready
    case error(error: String)
}
