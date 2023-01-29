//
//  HomeView.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 29.01.2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        switch viewModel.states {
        case .ready:
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .onAppear{
                    viewModel.fetchMovies()
                }
        case .loading:
            ProgressView()
        case .finished:
            Text(viewModel.topRatedMovies?.results.first?.originalTitle ?? "Finished")
        case .error(error: let error):
            Text(error)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
