//
//  CastsCell.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 1.02.2023.
//

import SwiftUI

struct CastsCell: View {
    let proxy = UIScreen.main.bounds
    var name: String?
    var url : URL
    var type: MovieType?
    
    var body: some View {
        VStack(spacing: 12) {
            movieImage()
                .cornerRadius(10)
            
            HStack {
                Text(name ?? "")
                    .modifier(AppViewBuilder(textFont: type == .people ? .subheadline : .caption2 , alingment: .leading))
                Spacer()
            }
        }
        .frame(width: type == .people ? proxy.size.width / 2.25 : proxy.size.width / 4.25, height: type == .people ? proxy.size.height / 3 : proxy.size.height / 4.25)
    }
    
    @ViewBuilder
    private func movieImage() -> some View {
        AsyncImage(url: url) { phase in
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

struct CastsCell_Previews: PreviewProvider {
    static var previews: some View {
        CastsCell( name: "Ehmo", url: .applicationDirectory, type: .people)
            .previewLayout(.sizeThatFits)
    }
}
