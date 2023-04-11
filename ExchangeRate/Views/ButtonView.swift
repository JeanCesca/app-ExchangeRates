//
//  ButtonView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 06/04/23.
//

import SwiftUI

struct ButtonView: View {
    
    var action: () -> Void
    var title: String
    var color: Color
    var font: Font
    var isUnderline: Bool
    
    var body: some View {
        Button(action: action) {
            if isUnderline {
                Text(title)
                    .font(font)
                    .bold()
//                    .frame(width: 50, height: 30)
                    .foregroundColor(color)

            } else {
                Text(title)
                    .font(font)
                    .bold()
                    .frame(width: 50, height: 30)
                    .foregroundColor(color)
                    .background(
                        Color.secondary
                    )
            }
        }
        .cornerRadius(10)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(action: {
            print("")
        }, title: "Botão", color: .blue, font: .callout, isUnderline: false)
    }
}
