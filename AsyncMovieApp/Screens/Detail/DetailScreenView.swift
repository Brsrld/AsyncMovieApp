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
    
    init(id: Int, type: MovieType) {
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
        LazyVStack(spacing: 24) {
            HeaderView(imageURl: viewModel.imageUrl ?? .applicationDirectory,
                       title: (viewModel.movieDetail?.title ?? viewModel.tvDetail?.name) ?? "",
                       rating: Int((viewModel.movieDetail?.voteAverage ?? viewModel.tvDetail?.voteAverage) ?? 0),
                       proxy: proxy)
            summary()
            casts(proxy: proxy)
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
            ScrollView(.horizontal) {
                LazyHGrid(rows: columnGrid(), spacing: 24){
                    if let data = viewModel.casts?.cast {
                        ForEach(data, id: \.id) { items in
                            CastsCell(content: items, proxy: proxy)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    
    @ViewBuilder
    private func summary() -> some View {
        VStack(spacing: 20) {
            HStack {
                Text("Summary")
                    .modifier(AppViewBuilder(textFont: .title, alingment: .leading))
                Spacer()
            }
            
            Text((viewModel.movieDetail?.overview ?? viewModel.tvDetail?.overview) ?? "")
                .modifier(AppViewBuilder(textFont: .callout, linelimit: 10, alingment: .leading))
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
        DetailScreenView(id: 31917, type: .tv)
    }
}
