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
        ZStack {
            switch viewModel.states {
            case .ready:
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            case .loading:
                ProgressView()
            case .finished:
                Text("finished")
                    .onAppear{
                        print(viewModel.topRatedMovies)
                    }
            case .error(error: let error):
                Text(error)
            case .none:
                Text("none")
            }
        }
        .onAppear{
            viewModel.fetchMovies()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
