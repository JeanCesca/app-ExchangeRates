//
//  FluctuationDataProvider.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 05/04/23.
//

import Foundation

protocol FluctuationDataProviderDelegate: DataProviderManagerDelegate {
//    func success(model: RateFluctuationResponse)
    func success(model: [RateFluctuation])
}

class FluctuationDataProvider: DataProviderManager<FluctuationDataProviderDelegate, [RateFluctuation]> {
        
    private let rateStore: RateStore
     
    init(rateStore: RateStore = RateStore()) {
        self.rateStore = rateStore
    }
    
    func fetchFluctuation(base: String, symbols: [String], startDate: String, endDate: String) {
        Task.init {
            do {
                let object = try await rateStore.fetchFluctuation(base: base, symbols: symbols, startDate: startDate, endDate: endDate)
                let model = object.rates.map { symbol, fluctuation in
                    return RateFluctuation(symbol: symbol, change: fluctuation.change, changePct: fluctuation.changePct, endRate: fluctuation.endRate)
                }

                delegate?.success(model: model)
            } catch {
                print("Erro no fluctuation dataprovider: \(error.localizedDescription)")
                delegate?.errorData(provider: delegate, error: error)
            }
        }
    }
}
