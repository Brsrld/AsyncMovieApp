//
//  DetailScreenView.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 1.02.2023.
//

import SwiftUI

struct DetailScreenView: View {
    @ObservedObject var viewModel: DetailScreenViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(id: Int?, type: MovieType) {
        self.viewModel = DetailScreenViewModel(id: id, type: type)
    }
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                baseView(proxy: proxy)
            }
            .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    private func baseView(proxy: GeometryProxy) -> some View {
        switch viewModel.states {
        case .ready:
            ProgressView()
                .onAppear{
                    viewModel.initializeService()
                }
        case .loading:
            ProgressView()
        case .finished:
            allComponents(proxy: proxy)
        case .error(error: let error):
            ProgressView()
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text("Error Message"),
                          message: Text(error),
                          dismissButton: Alert.Button.default(
                            Text("Ok"), action: {
                                presentationMode.wrappedValue.dismiss()
                            }
                          ))
                }
        }
    }
    
    @ViewBuilder
    private func allComponents(proxy: GeometryProxy) -> some View  {
        VStack(spacing: 24) {
            HeaderView(imageURl: viewModel.imageUrl ?? .applicationDirectory,
                       title: (viewModel.movieDetail?.title ?? viewModel.tvDetail?.name) ?? viewModel.personDetail?.name,
                       rating: viewModel.movieDetail?.voteAverage ?? viewModel.tvDetail?.voteAverage,
                       status: viewModel.personDetail?.knownForDepartment,
                       proxy: proxy,
                       isPeople: viewModel.personDetail?.name != nil)
            summary()
            switch viewModel.type {
            case .tv:
                casts(proxy: proxy)
            case .people:
                movie(proxy: proxy)
                tvs(proxy: proxy)
            case .movie:
                casts(proxy: proxy)
            }
        }
    }
    
    @ViewBuilder
    private func movie(proxy: GeometryProxy) -> some View {
        
        VStack {
            HStack {
                Text("Movies")
                    .modifier(AppViewBuilder(textFont: .title, alingment: .leading))
                Spacer()
            }
            .padding(.leading)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: columnGrid(), spacing: 24){
                    if let data = viewModel.personMovieCredits?.cast {
                        ForEach(data, id: \.id) { item in
                            NavigationLink(
                                destination: LazyView(DetailScreenView(id: item.id ?? 0, type: .movie)),
                                label: {
                                    CastsCell(name: item.title,
                                              url: viewModel.generateURL(imageUrl: item.posterPath))
                                })
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func casts(proxy: GeometryProxy) -> some View {
        VStack {
            HStack {
                Text("Casts")
                    .modifier(AppViewBuilder(textFont: .title, alingment: .leading))
                Spacer()
            }
            .padding(.leading)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: columnGrid(), spacing: 24){
                    if let data = viewModel.casts?.cast {
                        ForEach(data, id: \.id) { item in
                            NavigationLink(
                                destination: LazyView(DetailScreenView(id: item.id ?? 0, type: .people)),
                                label: {
                                    CastsCell(name: item.name,
                                              url: viewModel.generateURL(imageUrl: item.profilePath))
                                })
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func tvs(proxy: GeometryProxy) -> some View {
        VStack {
            HStack {
                Text("Tv's")
                    .modifier(AppViewBuilder(textFont: .title, alingment: .leading))
                Spacer()
            }
            .padding(.leading)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: columnGrid(), spacing: 24){
                    if let data = viewModel.personTVCredits?.cast {
                        ForEach(data, id: \.id) { item in
                            NavigationLink(
                                destination: LazyView(DetailScreenView(id: item.id ?? 0, type: .tv)),
                                label: {
                                    CastsCell(name: item.name,
                                              url: viewModel.generateURL(imageUrl: item.posterPath))
                                })
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    
    @ViewBuilder
    private func summary() -> some View {
        VStack(spacing: 20) {
            HStack {
                Text(viewModel.type == .people ? "Biography" :"Summary")
                    .modifier(AppViewBuilder(textFont: .title, alingment: .leading))
                Spacer()
            }
            
            switch viewModel.type {
            case .people:
                Text((viewModel.personDetail?.biography == "" ? "Biography does not exist" : viewModel.personDetail?.biography) ?? "")
                    .modifier(AppViewBuilder(textFont: .callout, linelimit: 100, alingment: .leading))
            case .tv:
                Text((viewModel.tvDetail?.overview == "" ? "Overview does not exist" : viewModel.tvDetail?.overview) ?? "")
                    .modifier(AppViewBuilder(textFont: .callout, linelimit: 100, alingment: .leading))
            case .movie:
                Text((viewModel.movieDetail?.overview == "" ? "Overview does not exist" : viewModel.movieDetail?.overview) ?? "")
                    .modifier(AppViewBuilder(textFont: .callout, linelimit: 100, alingment: .leading))
            }
        }
        .padding(.horizontal)
    }
    
    private func columnGrid() -> [GridItem] {
        return   [
            GridItem(.flexible())
        ]
    }
}

struct DetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreenView(id: 550, type: .movie)
    }
}
