//
//  TimeseriesDataProvider.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 05/04/23.
//

import Foundation

protocol TimeseriesDataProviderDelegate: DataProviderManagerDelegate {
    func success(model: TimeseriesResponse)
}

class TimeseriesDataProvider: DataProviderManager<TimeseriesDataProviderDelegate, TimeseriesResponse> {
    
    private let rateStore: RateStore
    
    init(rateStore: RateStore = RateStore()) {
        self.rateStore = rateStore
    }
    
    func fetchTimeseries(base: String, symbols: [String], startDate: String, endDate: String) {
        Task.init {
            do {
                let model = try await  rateStore.fetchTimeseries(base: base, symbols: symbols, startDate: startDate, endDate: endDate)
                delegate?.success(model: model)
            } catch {
                delegate?.errorData(provider: delegate, error: error)
            }
        }
    }
}
