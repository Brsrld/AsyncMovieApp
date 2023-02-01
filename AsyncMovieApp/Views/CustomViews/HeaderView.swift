//
//  HeaderView.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 1.02.2023.
//

import SwiftUI

struct HeaderView: View {
    var imageURl: URL
    var title: String
    var rating: Int
    var proxy: GeometryProxy
    
    var body: some View {
        VStack {
            ZStack {
                movieImage()
                    .opacity(0.2)
                VStack(spacing: 12) {
                    movieImage()
                        .cornerRadius(10)
                        .frame(width: proxy.size.height / 3)
                    
                    VStack {
                        Text(title)
                            .modifier(AppViewBuilder(textFont: .title, alingment: .center))
                        
                        RatingView(rating: 4)
                    }
                    .padding(.top)
                }
                .padding(.top, 32)
            }
        }
    }
    
    @ViewBuilder
    private func movieImage() -> some View {
        AsyncImage(url: imageURl) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                Image("fail")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    
    static var previews: some View {
        GeometryReader { proxy in
            HeaderView(imageURl: .applicationDirectory, title: "Raya and The Last Dragon", rating: 5, proxy: proxy)
                .previewLayout(.sizeThatFits)
        }
    }
}
