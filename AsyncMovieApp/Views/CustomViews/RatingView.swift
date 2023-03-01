//
//  RatingView.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 1.02.2023.
//

import SwiftUI

struct RatingView: View {
    var rating: Double?
    var maxRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.orange
    
    
    var body: some View {
        HStack {
            ForEach(1..<maxRating + 1, id: \.self) { number in
                image(for: number)
                    .resizable()
                    .foregroundColor(number > Int(rating ?? 0) ? offColor : onColor)
                    .frame(width: 32, height:32)
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > Int(rating ?? 0) {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 4)
    }
}
