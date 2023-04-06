//
//  RateStore.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 05/04/23.
//

import Foundation

protocol RateStoreProtocol {
    
    func fetchFluctuation(base: String, symbols: [String], startDate: String, endDate: String) async throws -> FluctuationResponse
    func fetchTimeseries(base: String, symbols: [String], startDate: String, endDate: String) async throws -> TimeseriesResponse
}

class RateStore: RateStoreProtocol, StoreProtocol {
    
    func fetchFluctuation(base: String, symbols: [String], startDate: String, endDate: String) async throws -> FluctuationResponse {
        guard let urlRequest = try RatesRouter.fluctuation(base: base, symbols: symbols, startDate: startDate, endDate: endDate)
            .asUrlRequest() else {
            print("BAR URL FETCH")
            throw URLError(.badURL)
        }
        
        return try await handleResponse(urlRequest: urlRequest, body: FluctuationResponse.self)
    }
    
    func fetchTimeseries(base: String, symbols: [String], startDate: String, endDate: String) async throws -> TimeseriesResponse {
        
        guard let urlRequest = try RatesRouter.timeseries(base: base, symbols: symbols, startDate: startDate, endDate: endDate)
            .asUrlRequest() else {
            print("BAR URL TIMESERIES")
            throw URLError(.badURL)
        }
        
        return try await handleResponse(urlRequest: urlRequest, body: TimeseriesResponse.self)
    }
}

