//
//  FluctuationDataProvider.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 05/04/23.
//

import Foundation

protocol FluctuationDataProviderDelegate: DataProviderManagerDelegate {
    func success(model: FluctuationResponse)
}

class FluctuationDataProvider: DataProviderManager<FluctuationDataProviderDelegate, FluctuationResponse> {
    
    private let rateStore: RateStore
    
    init(rateStore: RateStore = RateStore()) {
        self.rateStore = rateStore
    }
    
    func fetchFluctuation(base: String, symbols: [String], startDate: String, endDate: String) {
        Task.init {
            do {
                let model = try await rateStore.fetchFluctuation(base: base, symbols: symbols, startDate: startDate, endDate: endDate)
                delegate?.success(model: model)
            } catch {
                delegate?.errorData(provider: delegate, error: error)
            }
        }
    }
}
