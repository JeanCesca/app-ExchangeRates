//
//  ButtonView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 06/04/23.
//

import SwiftUI

struct PeriodButton: View {
    
    var action: () -> Void
    var title: String
    var color: Color
    var isUnderline: Bool
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.callout)
                .bold()
                .foregroundColor(color)
                .underline(isUnderline, color: color)
        }
        .cornerRadius(10)
    }
}

struct PeriodButton_Previews: PreviewProvider {
    static var previews: some View {
        PeriodButton(action: {
            print("")
        }, title: "Botão", color: .blue, isUnderline: false)
    }
}
