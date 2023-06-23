//
//  RateFluctuation.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 12/04/23.
//

import Foundation

struct RateFluctuation: Identifiable, Equatable {
    let id = UUID()
    var symbol: String
    var change: Double
    var changePct: Double
    var endRate: Double
}
