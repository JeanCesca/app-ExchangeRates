//
//  FluctuationPeriodButtons.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 11/04/23.
//

import SwiftUI

struct Period: Identifiable {
    let id = UUID()
    let period: String
    let tab: PeriodSelected
}

var selectedPeriod: [Period] = [
    Period(period: "1 dia", tab: .oneDay),
    Period(period: "7 dias", tab: .sevenDays),
    Period(period: "1 mês", tab: .oneMonth),
    Period(period: "6 meses", tab: .sixMonths),
    Period(period: "1 ano", tab: .oneYear)
]

enum PeriodSelected: String {
    case oneDay
    case sevenDays
    case oneMonth
    case sixMonths
    case oneYear
}


struct FluctuationPeriodButtons: View {

    @Binding var selection: PeriodSelected
        
    var body: some View {
        HStack {
            ForEach(selectedPeriod) { period in
                PeriodButton(action: {
                    selection = period.tab
                },
                           title: period.period,
                           color: selection == period.tab ? Color.blue : Color.gray,
                           isUnderline: selection == period.tab ? true : false)
            }
        }
    }
}

struct FluctuationPeriodButtons_Previews: PreviewProvider {
    static var previews: some View {
        FluctuationPeriodButtons(selection: .constant(.oneDay))
    }
}
