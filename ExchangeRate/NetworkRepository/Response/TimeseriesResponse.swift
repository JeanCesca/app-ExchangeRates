//
//  TimeseriesResponse.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 05/04/23.
//

import Foundation

typealias TimeseriesRate = [String: TimeseriesRateValues]
typealias TimeseriesRateValues = [String: Double]

struct TimeseriesResponse: Codable {
    let success, timeseries: Bool
    let startDate, endDate, base: String
    let rates: TimeseriesRate

    enum CodingKeys: String, CodingKey {
        case success, timeseries
        case startDate = "start_date"
        case endDate = "end_date"
        case base, rates
    }
}
