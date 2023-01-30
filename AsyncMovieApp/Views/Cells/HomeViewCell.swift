//
//  HomeViewCell.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 30.01.2023.
//

import SwiftUI

struct HomeViewCell: View {
    let screenBounds = UIScreen.main.bounds
    @ObservedObject var viewModel: HomeCellViewModel
    
    init(content:MovieModel) {
        self.viewModel = HomeCellViewModel(content: content)
    }
    
    var body: some View {
        HStack{
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
                    Image(systemName: "photo")
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
                Text(viewModel.content.title)
                    .modifier(AppViewBuilder(textFont: .title3, linelimit: 2))
                    .padding(.horizontal,18)
                    .padding(.top, 8)
                    .frame(height: 64)
                Text(viewModel.content.overview)
                    .modifier(AppViewBuilder(textFont: .footnote, linelimit: 4))
                    .padding(.horizontal, 18)
                    .padding(.bottom, 8)
                 
            }
            .background(Color.white)
            .cornerRadius(8, corners: [.bottomRight, .topRight])
            .shadow(radius: 2)
            .frame(width: screenBounds.width / 1.55)
            .padding(.top)
        }
    }
}
