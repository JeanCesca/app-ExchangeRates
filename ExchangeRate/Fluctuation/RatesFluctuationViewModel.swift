//
//  FluctuationViewModel.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 12/04/23.
//

import Foundation
import SwiftUI

@MainActor
final class RatesFluctuationViewModel: ObservableObject {
        
    @Published var searchText: String = ""
    @Published var periodSelected: PeriodSelected = .oneDay
    
    @Published var isNegative: Bool = false
    @Published var isPresentedBaseCurrencyFilter: Bool = false
    @Published var isPresentedMultiCurrencyFilter: Bool = false
        
    @Published var ratesFluctuations: [RateFluctuation] = []
    @Published var timeRange: TimeRange = .today
    @Published var baseCurrency: String? = "BRL"
    @Published var currencies: [String] = []
    
    private let dataProvider: FluctuationDataProvider
    
    init(dataProvider: FluctuationDataProvider = FluctuationDataProvider()) {
        self.dataProvider = dataProvider
        self.dataProvider.delegate = self
    }

    func doFetchRatesFluctuation(timeRange: TimeRange) {
        withAnimation {
            self.timeRange = timeRange
        }
        
        let startDate = timeRange.date.toString()
        let endDate = Date().toString()
        
        dataProvider.fetchFluctuation(
            base: baseCurrency ?? "",
            symbols: currencies,
            startDate: startDate,
            endDate: endDate)
    }
    
    var searchResult: [RateFluctuation] {
        if searchText.isEmpty {
            return ratesFluctuations
        } else {
            return filterFluctuations(input: ratesFluctuations)
        }
    }
    
    func filterFluctuations(input: [RateFluctuation]) -> [RateFluctuation] {
        return ratesFluctuations.filter {
            $0.symbol.contains(searchText.uppercased()) ||
            $0.change.formatter(decimalPlaces: 4).contains(searchText.uppercased()) ||
            $0.changePct.toPercentage().contains(searchText.uppercased()) ||
            $0.endRate.formatter(decimalPlaces: 2).contains(searchText.uppercased())
        }
    }
}

extension RatesFluctuationViewModel: FluctuationDataProviderDelegate {
    
    func success(model: [RateFluctuation]) {
        DispatchQueue.main.async {
            withAnimation {
                self.ratesFluctuations = model.sorted(by: { item1, item2 in
                    return item1.symbol > item2.symbol
                })
            }
        }
    }
}


