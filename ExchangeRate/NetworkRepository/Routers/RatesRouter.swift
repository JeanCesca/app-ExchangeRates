//
//  RatesRouter.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 05/04/23.
//

import Foundation

enum RatesRouter {
    
    //query items
    case fluctuation(base: String, symbols: [String], startDate: String, endDate: String)
    case timeseries(base: String, symbol: String, startDate: String, endDate: String)
    
    var path: String {
        switch self {
        case .fluctuation:
            return RatesAPI.fluctuation
        case .timeseries:
            return RatesAPI.timeseries
        }
    }
    
    func asUrlRequest() throws -> URLRequest? {
        guard var url = URL(string: RatesAPI.baseUrl) else {
            print("REQUEST URL RUIM")
            throw URLError(.badURL)
        }
        
        switch self {
        case .fluctuation(let base, let symbols, let startDate, let endDate):
            url.append(queryItems: [
                URLQueryItem(name: "base", value: base),
                URLQueryItem(name: "symbols", value: symbols.joined(separator: ",")),
                URLQueryItem(name: "start_date", value: startDate),
                URLQueryItem(name: "end_date", value: endDate)
            ])
        case .timeseries(let base, let symbol, let startDate, let endDate):
            url.append(queryItems: [
                URLQueryItem(name: "base", value: base),
                URLQueryItem(name: "symbols", value: symbol),
                URLQueryItem(name: "start_date", value: startDate),
                URLQueryItem(name: "end_date", value: endDate)
            ])
        }
        
        let urlPath = url.appending(path: path)
        
        var request = URLRequest(url: urlPath, timeoutInterval: Double.infinity)
        request.httpMethod = HttpMethod.get.rawValue
        request.addValue(RatesAPI.APIKey, forHTTPHeaderField: "apikey")
        
        return request
    }
}
