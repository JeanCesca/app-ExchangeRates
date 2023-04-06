//
//  RatesAPI.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 05/04/23.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct RatesAPI {
    
    static let baseUrl = "https://api.apilayer.com/exchangerates_data"
    static let APIKey = "KXhmmN4Azb0Fgq9fjRumqAfLF8LUXVgR"
    
    static let fluctuation = "/fluctuation"
    static let symbols = "/symbols"
    static let timeseries = "/timeseries"
}




