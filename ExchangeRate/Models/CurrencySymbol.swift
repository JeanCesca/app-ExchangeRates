//
//  Symbol.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 12/04/23.
//

import Foundation

struct CurrencySymbol: Identifiable {
    let id = UUID()
    var symbol: String
    var fullName: String
}
