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
    @State var movieType: MovieType = .movie
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            baseView()
        }
        .navigationBarTitleDisplayMode(.automatic)
        .navigationTitle(movieType.title)
        .searchable(text: $searchText, placement: .toolbar)
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
            chooseMovieType()
            movieList(content: viewModel.serviceContents?.results)
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
    private func movieList(content:[ModelResults]?) -> some View {
        
        LazyVStack(spacing:-8) {
            if let data = content {
                ForEach(data, id: \.id) { movie in
                    VStack {
                        NavigationLink(
                            destination: LazyView(DetailScreenView(id: movie.id ?? 0, type: movieType)),
                            label: {
                                HomeViewCell(title: (movieType == .movie ? movie.title : movie.name) ,
                                             overView: movieType == .people ? "movie.knownFor?.first?.overview ": movie.overview,
                                             imageURL: viewModel.generateURL(imageUrl: movieType == .people ? movie.profilePath: movie.posterPath))
                            })
                    }
                    .onAppear{
                        viewModel.movieType = movieType
                        viewModel.loadMoreContent(movieModel: movie)
                    }
                }
            }
        }
        .padding(.top)
    }
    
    @ViewBuilder
    private func chooseMovieType() -> some View {
        Picker("", selection: $movieType) {
            ForEach(viewModel.movieTypes, id: \.self) {
                Text($0.title)
            }
        }
        .onChange(of: movieType, perform: { newValue in
            viewModel.movieType = newValue
            viewModel.changeStateToReady()
            viewModel.fetchMovies(page: 1)
            self.movieType = newValue
        })
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
