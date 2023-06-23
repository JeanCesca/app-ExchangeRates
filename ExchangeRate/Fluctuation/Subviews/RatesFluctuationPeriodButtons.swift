//
//  FluctuationPeriodButtons.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 11/04/23.
//

import SwiftUI

enum PeriodSelected: String {
    case oneDay
    case sevenDays
    case oneMonth
    case sixMonths
    case oneYear
}

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

struct RatesFluctuationPeriodButtons: View {

    @Binding var selection: PeriodSelected
    @State var vm: RatesFluctuationViewModel
        
    var body: some View {
        HStack {
            ForEach(selectedPeriod) { period in
                PeriodButton(action: {
                    selection = period.tab
                    switch selection {
                    case .oneDay:
                        vm.doFetchRatesFluctuation(timeRange: .today)
                    case .sevenDays:
                        vm.doFetchRatesFluctuation(timeRange: .thisWeek)
                    case .oneMonth:
                        vm.doFetchRatesFluctuation(timeRange: .thisMonth)
                    case .sixMonths:
                        vm.doFetchRatesFluctuation(timeRange: .thisSemester)
                    case .oneYear:
                        vm.doFetchRatesFluctuation(timeRange: .thisYear)
                    }
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
        RatesFluctuationPeriodButtons(
            selection: .constant(.oneDay),
            vm: RatesFluctuationViewModel())
    }
}
