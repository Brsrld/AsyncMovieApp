//
//  DetailScreenView.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 1.02.2023.
//

import SwiftUI

struct DetailScreenView: View {
    let screenBounds = UIScreen.main.bounds
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 24) {
                    HeaderView(imageURl: .applicationDirectory, title: "Raya and The Last Dragon", rating: 3, proxy: proxy)
                        summary()
                }
            }
            .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    private func summary() -> some View {
        VStack(spacing: 20) {
            HStack {
                Text("Summary")
                .modifier(AppViewBuilder(textFont: .title, alingment: .leading))
                Spacer()
            }
            
            Text("A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.")
                .modifier(AppViewBuilder(textFont: .callout, linelimit: 10, alingment: .leading))
        }
        .padding(.horizontal)
    }
}

struct DetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreenView()
    }
}
