//
//  RateFluctuation.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 05/04/23.
//

import Foundation

typealias FluctuationRates = [String: RateValues]

struct FluctuationResponse: Codable {
    let success, fluctuation: Bool
    let startDate, endDate, base: String
    let rates: FluctuationRates

    enum CodingKeys: String, CodingKey {
        case success, fluctuation
        case startDate = "start_date"
        case endDate = "end_date"
        case base, rates
    }
}

struct RateValues: Codable {
    let startRate, endRate, change, changePct: Double

    enum CodingKeys: String, CodingKey {
        case startRate = "start_rate"
        case endRate = "end_rate"
        case change
        case changePct = "change_pct"
    }
}
