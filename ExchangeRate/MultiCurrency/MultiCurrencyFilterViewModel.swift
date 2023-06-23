//
//  MultiCurrencyFilterViewModel.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 12/04/23.
//

import Foundation
import SwiftUI

@MainActor
final class MultiCurrencyFilterViewModel: ObservableObject {
    
    private let dataProvider: CurrencySymbolDataProvider?
    
    @Published var currencySymbols: [CurrencySymbol] = []
    
    init(dataProvider: CurrencySymbolDataProvider? = CurrencySymbolDataProvider()) {
        self.dataProvider = dataProvider
        self.dataProvider?.delegate = self
    }
    
    public func doFetchMultiCurrencySymbols() {
        dataProvider?.fetchCurrencySymbols()
    }
}

extension MultiCurrencyFilterViewModel: CurrencySymbolDataProviderDelegate {
    
    func success(model: [CurrencySymbol]) {
        DispatchQueue.main.async {
            withAnimation {
                self.currencySymbols = model.sorted { $0.symbol < $1.symbol }
            }
        }
    }
}



