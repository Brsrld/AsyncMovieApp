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
        baseView()
            .onAppear{
                viewModel.fetchMovies()
            }
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("Top Rated")
            .searchable(text: $viewModel.searchText)
    }
    
    @ViewBuilder
    private func baseView() -> some View {
        switch viewModel.states {
        case .ready:
            ProgressView()
        case .loading:
            ProgressView()
        case .finished:
            movieList(content: viewModel.topRatedMovies)
        case .error(error: let error):
            Text(error)
        case .searching:
            movieList(content: viewModel.filteredData)
        }
    }
    
    @ViewBuilder
    private func movieList(content:[MovieModel]) -> some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing:-8) {
                    ForEach(content, id: \.id) { movie in
                        HomeViewCell(content: movie)
                    }
                }
            }
        }
        .padding(.top)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
