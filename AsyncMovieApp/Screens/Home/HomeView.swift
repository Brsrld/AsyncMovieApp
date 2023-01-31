//
//  HomeView.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 29.01.2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @State private var searchText = ""
    
    var body: some View {
        baseView()
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("Top Rated")
            .searchable(text: $searchText)
            .onChange(of: searchText) { newValue in
                viewModel.search(searchTerm: newValue)
            }
    }
    
    @ViewBuilder
    private func baseView() -> some View {
        switch viewModel.states {
        case .loading:
            ProgressView()
        case .finished:
            movieList(content: viewModel.topRatedMovies?.results)
        case .searching:
            movieList(content: viewModel.filteredData)
        case .ready:
            ProgressView()
                .onAppear{
                    viewModel.fetchMovies(page: 1)
                }
        case .error(error: let error):
            ProgressView()
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text("Error Message"),
                          message: Text(error),
                          dismissButton: Alert.Button.default(
                            Text("Ok"), action: {
                                viewModel.changeStateToReady()
                            }
                          ))
                }
        }
    }
    
    @ViewBuilder
    private func movieList(content:[MovieModel]?) -> some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing:-8) {
                    if let data = content {
                        ForEach(data, id: \.id) { movie in
                            HomeViewCell(content: movie)
                                .onAppear{
                                    viewModel.loadMoreContent(movieModel: movie)
                                }
                        }
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
