//
//  AppViewBuilder.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 30.01.2023.
//

import SwiftUI

struct AppViewBuilder: ViewModifier {

    let textColor: Color
    let textFont: Font
    let lineLimit: Int
    
    init(textColor: Color = Color.black,
         textFont:Font,
         linelimit:Int = 1) {
        self.textColor = textColor
        self.textFont = textFont
        self.lineLimit = linelimit
    }
    func body(content: Content) -> some View{
        content
            .font(textFont)
            .foregroundColor(textColor)
            .lineLimit(lineLimit)
           
    }
}
