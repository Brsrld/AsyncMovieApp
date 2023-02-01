//
//  CastsCell.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 1.02.2023.
//

import SwiftUI

struct CastsCell: View {
    var proxy: GeometryProxy
    var viewModel: CastsCellViewModel
    
    init(content:Cast, proxy: GeometryProxy) {
        self.viewModel = CastsCellViewModel(content: content)
        self.proxy = proxy
    }
    
    var body: some View {
        VStack(spacing: 12) {
            movieImage()
                .cornerRadius(10)
            
            HStack {
                Text(viewModel.name)
                    .modifier(AppViewBuilder(textFont: .caption2, alingment: .leading))
                Spacer()
            }
        }
        .frame(width: proxy.size.width / 4.25, height: proxy.size.height / 4.25)
    }
    
    @ViewBuilder
    private func movieImage() -> some View {
        AsyncImage(url: viewModel.imageUrl) { phase in
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
        GeometryReader { proxy in
            CastsCell(content: .init(), proxy: proxy)
                .previewLayout(.sizeThatFits)
        }
    }
}
