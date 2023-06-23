//
//  SymbolsDataProvider.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 05/04/23.
//

import Foundation

protocol CurrencySymbolDataProviderDelegate: DataProviderManagerDelegate {
    func success(model: [CurrencySymbol])
}

class CurrencySymbolDataProvider: DataProviderManager<CurrencySymbolDataProviderDelegate, [CurrencySymbol]> {
    
    private let currencySymbolStore: CurrencySymbolStore
    
    init(currencySymbolStore: CurrencySymbolStore = CurrencySymbolStore()) {
        self.currencySymbolStore = currencySymbolStore
    }
    
    func fetchCurrencySymbols() {
        Task.init {
            do {
                let object = try await currencySymbolStore.fetchSymbols()
                
                let model = object.symbols.map { (symbol, fullName) in
                    return CurrencySymbol(symbol: symbol, fullName: fullName)
                }
                
                delegate?.success(model: model)
            } catch {
                print("Erro no symbol dataprovider: \(error)")
                delegate?.errorData(provider: delegate, error: error)
            }
        }
    }
}
