//
//  SymbolButton.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 11/04/23.
//

import SwiftUI

struct SymbolButton: View {
    
    @State var action: () -> Void
    @Binding var title: String?
    
    let color: Color
    
    var body: some View {
        Button(action: action) {
            Text(title ?? "")
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
        SymbolButton(action: {}, title: .constant("BRL"), color: .white)
    }
}
