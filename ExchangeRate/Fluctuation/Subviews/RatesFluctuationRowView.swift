//
//  FluctuationRowView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 11/04/23.
//

import SwiftUI

struct RatesFluctuationRowView: View {
    
    @ObservedObject var vm: RatesFluctuationViewModel
    @State var fluctuation: RateFluctuation
          
    var body: some View {
        VStack {
            HStack {
                Text("\(fluctuation.symbol) / \(vm.baseCurrency ?? "")")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .fontWeight(.regular)
                    .frame(width: 85, alignment: .leading)
                    .minimumScaleFactor(0.5)
                
                Spacer()
                                
                Text(fluctuation.endRate.formatter(decimalPlaces: 2))
                    .minimumScaleFactor(0.75)
                    .lineLimit(1)
                    .layoutPriority(1)
                    .font(.callout)
                    .bold()
                    .font(.callout)
                    .frame(width: 70, alignment: .trailing)
                                
                Text(fluctuation.change.formatter(decimalPlaces: 4, changeSymbol: true))
                    .minimumScaleFactor(0.75)
                    .lineLimit(1)
                    .layoutPriority(1)
                    .font(.callout)
                    .bold()
                    .foregroundColor(fluctuation.change.color)
                    .frame(width: 70, alignment: .trailing)

                Text("(\(fluctuation.changePct.toPercentage(changeSymbol: true)))")
                    .minimumScaleFactor(0.75)
                    .lineLimit(1)
                    .font(.caption)
                    .bold()
                    .foregroundColor(fluctuation.changePct.color)
                
            }
            .frame(height: 32)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.leading)
        }
    }
}

struct FluctuationRowView_Previews: PreviewProvider {
    static var previews: some View {
        RatesFluctuationRowView(vm: RatesFluctuationViewModel(), fluctuation: RateFluctuation(
                                symbol: "USD",
                                change: 0.11111111,
                                changePct: 0.222111111111,
                                endRate: 0.333))
    }
}
