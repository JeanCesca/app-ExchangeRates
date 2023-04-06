//
//  SymbolsDataProvider.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 05/04/23.
//

import Foundation

protocol SymbolsDataProviderDelegate: DataProviderManagerDelegate {
    func success(model: SymbolsResponse)
}

class SymbolsDataProvider: DataProviderManager<SymbolsDataProviderDelegate, SymbolsResponse> {
    
    private let symbolStore: SymbolStore
    
    init(symbolStore: SymbolStore = SymbolStore()) {
        self.symbolStore = symbolStore
    }
    
    func fetchSymbols() {
        Task.init {
            do {
                let model = try await symbolStore.fetchSymbols()
                delegate?.success(model: model)
            } catch {
                delegate?.errorData(provider: delegate, error: error)
            }
        }
    }
}
