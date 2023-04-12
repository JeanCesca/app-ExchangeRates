//
//  FluctuationRowView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 11/04/23.
//

import SwiftUI

struct FluctuationRowView: View {
    
    @State var fluctuation: Fluctuation
          
    var body: some View {
        VStack {
            HStack {
                Text("\(fluctuation.symbol) / BRL")
                    .font(.headline)
                    .bold()
                    .fontWeight(.regular)
                                
                Spacer()
                Spacer()
                Spacer()
                
                Text(fluctuation.endRate.formatter(decimalPlaces: 2))
                    .font(.callout)
                    .bold()
                
                Spacer()
                
                Text(fluctuation.change.formatter(decimalPlaces: 4, changeSymbol: true))
                    .font(.callout)
                    .bold()
                    .foregroundColor(fluctuation.change.color)
                
                Spacer()
                
                Text("(\(fluctuation.changePct.toPercentage(changeSymbol: true)))")
                    .font(.callout)
                    .bold()
                    .foregroundColor(fluctuation.changePct.color)
            }
        }
    }
}

struct FluctuationRowView_Previews: PreviewProvider {
    static var previews: some View {
        FluctuationRowView(fluctuation: Fluctuation(
                                symbol: "USD",
                                change: 0.111,
                                changePct: 0.222,
                                endRate: 0.333))
    }
}
