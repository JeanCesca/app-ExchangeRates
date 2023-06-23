//
//  TimeseriesDataProvider.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 05/04/23.
//

import Foundation

protocol TimeseriesDataProviderDelegate: DataProviderManagerDelegate {
    func success(model: [HistoricalRate])
}

class TimeseriesDataProvider: DataProviderManager<TimeseriesDataProviderDelegate, [HistoricalRate]> {
    
    private let rateStore: RateStore
    
    init(rateStore: RateStore = RateStore()) {
        self.rateStore = rateStore
    }
    
    func fetchTimeseries(base: String, symbol: String, startDate: String, endDate: String) {
        Task.init {
            do {
                let object = try await rateStore.fetchTimeseries(base: base, symbol: symbol, startDate: startDate, endDate: endDate)
                let model = object.rates.flatMap { period, timeseries in
                    return timeseries.map { symbol, endRate in
                        return HistoricalRate(symbol: symbol, period: period.toDate(), endRate: endRate)
                    }
                }
                
                delegate?.success(model: model)
            } catch {
                print("Erro no timeseries dataprovider FETCH: \(error)")
                delegate?.errorData(provider: delegate, error: error)
            }
        }
    }
}
