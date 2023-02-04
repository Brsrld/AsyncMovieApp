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
    
    init(content: ModelResults, type: MovieType) {
        self.viewModel = DetailScreenViewModel(content: content, type: type)
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
                       title: (viewModel.movieDetail?.title ?? viewModel.tvDetail?.name) ?? viewModel.personDetail?.name ?? "",
                       rating: Int((viewModel.movieDetail?.voteAverage ?? viewModel.tvDetail?.voteAverage) ?? 0),
                       status: viewModel.personDetail?.knownForDepartment ?? "",
                       proxy: proxy,
                       isPeople: viewModel.personDetail?.name != nil)
            summary()
            casts(proxy: proxy)
        }
    }
    
    @ViewBuilder
    private func casts(proxy: GeometryProxy) -> some View {
        VStack {
            HStack {
                Text(viewModel.type == .people ? "Known For" :"Casts")
                    .modifier(AppViewBuilder(textFont: .title, alingment: .leading))
                Spacer()
            }
            .padding(.leading)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: columnGrid(), spacing: 24){
                    if let data = viewModel.casts?.cast {
                        ForEach(data, id: \.id) { item in
                            CastsCell(proxy: proxy,
                                      name: item.name ?? "",
                                      url: viewModel.generateURL(imageUrl: item.profilePath ?? ""))
                        }
                    } else {
                        if let data = viewModel.content.knownFor {
                            ForEach(data, id: \.id) { item in
                                CastsCell(proxy: proxy, name: item.title ?? "",
                                          url: viewModel.generateURL(imageUrl: item.posterPath ?? ""))
                            }
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
            
            Text((viewModel.movieDetail?.overview ?? viewModel.tvDetail?.overview) ?? viewModel.personDetail?.biography ?? "")
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

//struct DetailScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailScreenView(content: .init(adult: <#T##Bool?#>, backdropPath: <#T##String?#>, genreIDS: <#T##[Int]?#>, id: <#T##Int?#>, originalLanguage: <#T##String?#>, originalTitle: <#T##String?#>, popularity: <#T##Double?#>, posterPath: <#T##String?#>, releaseDate: <#T##String?#>, title: <#T##String?#>, name: <#T##String?#>, video: <#T##Bool?#>, voteAverage: <#T##Double?#>, voteCount: <#T##Int?#>, profilePath: <#T##String?#>, knownFor: <#T##[KnownFor]?#>), type: .tv)
//    }
//}
