//
//  HeaderView.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 1.02.2023.
//

import SwiftUI

struct HeaderView: View {
    var imageURl: URL
    var title: String?
    var rating: Double?
    var status: String?
    var proxy: GeometryProxy
    var isPeople: Bool
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    movieImage()
                        .opacity(0.2)
                }
                VStack(spacing: 12) {
                    movieImage()
                        .cornerRadius(10)
                        .frame(width: proxy.size.height / 3)
                    VStack(spacing: 12) {
                        Text(title ?? "")
                            .modifier(AppViewBuilder(textFont: .title, linelimit: 2, alingment: .center))
                            .padding(.horizontal)
                        ratingView()
                    }
                    .padding(.top)
                }
                .padding(.top, isPeople ? 116 : 64)
            }
        }
    }
    
    @ViewBuilder
    private func ratingView() -> some View {
        if isPeople {
            Text(status ?? "")
                .modifier(AppViewBuilder(textFont: .headline, alingment: .center))
            RatingView(rating: rating)
                .hidden()
        } else {
            RatingView(rating: rating)
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
            HeaderView(imageURl: .applicationDirectory, title: "Raya and The Last Dragon", rating: 0, status: "Kahta", proxy: proxy, isPeople: false )
                .previewLayout(.sizeThatFits)
        }
    }
}
