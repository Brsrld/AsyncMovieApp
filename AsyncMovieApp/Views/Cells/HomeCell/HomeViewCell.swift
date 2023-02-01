//
//  HomeViewCell.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 30.01.2023.
//

import SwiftUI

struct HomeViewCell: View {
    let screenBounds = UIScreen.main.bounds
    var viewModel: HomeCellViewModel
    
    init(content:Results) {
        self.viewModel = HomeCellViewModel(content: content)
    }
    
    var body: some View {
        HStack(spacing:-8) {
            Spacer()
            ZStack {
                movieText()
                movieImage()
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func movieImage() -> some View {
        HStack {
            AsyncImage(url: viewModel.imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .cornerRadius(8)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: screenBounds.height / 5)
                        .shadow(radius: 2)
                case .failure:
                    Image("fail")
                        .resizable()
                        .cornerRadius(8)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: screenBounds.height / 5)
                        .shadow(radius: 2)
                @unknown default:
                    EmptyView()
                }
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func movieText() -> some View {
        HStack {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text(viewModel.title == "" ? viewModel.name : viewModel.title)
                    .modifier(AppViewBuilder(textFont: .title3, linelimit: 2, alingment: .leading))
                    .padding(.horizontal,18)
                    .padding(.top, 8)
                    .frame(height: 64)
                Text(viewModel.overView == "" ? viewModel.knownForMovies : viewModel.overView)
                    .modifier(AppViewBuilder(textFont: .footnote, linelimit: 4, alingment: .leading))
                    .padding(.horizontal, 18)
                    .padding(.bottom, 8)
                    .frame(width: screenBounds.width / 1.55, height: 75)
                 
            }
            .background(Color.white)
            .cornerRadius(8, corners: [.bottomRight, .topRight])
            .shadow(radius: 2)
            .frame(width: screenBounds.width / 1.55)
            .padding(.top)
        }
    }
}

struct HomeViewCell_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { proxy in
            HomeViewCell(content: .init())
                .previewLayout(.sizeThatFits)
        }
    }
}
