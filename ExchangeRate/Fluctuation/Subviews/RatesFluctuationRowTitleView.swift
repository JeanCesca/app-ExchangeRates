//
//  RatesFluctuationRowTitleView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 12/04/23.
//

import SwiftUI

struct RatesFluctuationRowTitleView: View {
    
    var body: some View {
        VStack {
            HStack {
                Text("Moeda")
                
                Spacer()
        
                Text("Taxa atual")
                    .frame(width: 70, alignment: .trailing)
                Text("Taxa change")
                    .frame(width: 70, alignment: .trailing)
                Text("Percentual")
                
            }
            .font(.caption)
            .bold()
            .frame(height: 32)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.leading)
        }
    }
}

struct RatesFluctuationRowTitleView_Previews: PreviewProvider {
    static var previews: some View {
        RatesFluctuationRowTitleView()
    }
}
