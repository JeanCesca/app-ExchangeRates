//
//  SymbolsResponse.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 05/04/23.
//

import Foundation

typealias Symbols = [String: String]

struct CurrencySymbolResponse: Codable {
    let success: Bool
    let symbols: Symbols
}
