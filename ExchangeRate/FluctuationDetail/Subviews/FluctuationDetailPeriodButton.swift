//
//  FluctuationPeriodButtons.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 11/04/23.
//

import SwiftUI

struct FluctuationDetailPeriodButton: View {

    @Binding var selection: PeriodSelected
    @ObservedObject var vm: RatesFluctuationDetailViewModel
        
    var body: some View {
        HStack {
            ForEach(selectedPeriod) { period in
                PeriodButton(action: {
                    selection = period.tab
                    switch selection {
                    case .oneDay:
                        vm.doFetchData(from: .today)
                    case .sevenDays:
                        vm.doFetchData(from: .thisWeek)
                    case .oneMonth:
                        vm.doFetchData(from: .thisMonth)
                    case .sixMonths:
                        vm.doFetchData(from: .thisSemester)
                    case .oneYear:
                        vm.doFetchData(from: .thisYear)
                    }
                },
                           title: period.period,
                             color: selection == period.tab ? Color.blue : Color.gray,
                             isUnderline: selection == period.tab ? true : false)
            }
        }
    }
}

struct FluctuationDetailPeriodButton_Previews: PreviewProvider {
    static var previews: some View {
        FluctuationDetailPeriodButton(
            selection: .constant(.oneDay),
            vm: RatesFluctuationDetailViewModel())
    }
}
