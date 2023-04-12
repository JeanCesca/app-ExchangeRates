//
//  ComparationGridButtonView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 11/04/23.
//

import SwiftUI

struct ComparationGridButtonView: View {

    @State var fluctuation: Fluctuation
    @Binding var baseCurrency: String

    var body: some View {
        VStack(spacing: 4) {
            Text("\(fluctuation.symbol) / \(baseCurrency)")
                .font(.title3)
                .foregroundColor(.accentColor)
            Text(fluctuation.endRate.formatter(decimalPlaces: 4))
            HStack {
                Text(fluctuation.symbol)
                    .foregroundColor(.black.opacity(0.8))
                Text(fluctuation.changePct.toPercentage())
                    .foregroundColor(
                        fluctuation.changePct.color
                    )
            }
            .font(.callout)
            .fontWeight(.semibold)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 4)
        )
    }
}

struct ComparationGridButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ComparationGridButtonView(fluctuation: Fluctuation(
            symbol: "BRL",
            change: 0.2390,
            changePct: 0.9023,
            endRate: 0.8293), baseCurrency: .constant("baseCurrency"))
    }
}
