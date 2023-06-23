//
//  BaseCurrencyViewModel.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 12/04/23.
//

import Foundation
import SwiftUI
    
@MainActor
final class BaseCurrencyViewModel: ObservableObject {
    
    private let dataProvider: CurrencySymbolDataProvider?
    
    @Published var currencySymbols: [CurrencySymbol] = []
    
    init(dataProvider: CurrencySymbolDataProvider? = CurrencySymbolDataProvider()) {
        self.dataProvider = dataProvider
        self.dataProvider?.delegate = self
    }
    
    public func doFetchCurrencySymbols() {
        dataProvider?.fetchCurrencySymbols()
    }
}

extension BaseCurrencyViewModel: CurrencySymbolDataProviderDelegate {
    func success(model: [CurrencySymbol]) {
        DispatchQueue.main.async {
            self.currencySymbols = model.sorted(by: { item1, item2 in
                return item1.symbol < item2.symbol
            })
        }
    }
}

