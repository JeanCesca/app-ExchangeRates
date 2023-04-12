//
//  SymbolButton.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 11/04/23.
//

import SwiftUI

struct SymbolButton: View {
    
    @State var action: () -> Void
    @State var title: String
    @State var color: Color
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.callout)
                .bold()
                .frame(width: 50, height: 30)
                .foregroundColor(color)
                .background(
                    Color.secondary
                )
        }
        .cornerRadius(10)
    }
}

struct SymbolButton_Previews: PreviewProvider {
    static var previews: some View {
        SymbolButton(action: {}, title: "BRL", color: .white)
    }
}
