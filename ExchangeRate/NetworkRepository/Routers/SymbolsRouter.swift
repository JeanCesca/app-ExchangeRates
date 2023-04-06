//
//  CurrencyRouter.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 05/04/23.
//

import Foundation

enum SymbolsRouter {
    
    case symbols
    
    var path: String {
        switch self {
        case .symbols:
            return RatesAPI.symbols
        }
    }
    
    func asUrlRequest() throws -> URLRequest? {
        guard let url = URL(string: RatesAPI.baseUrl) else {
            throw URLError(.badURL)
        }
        
        switch self {
        case .symbols:
            let urlPath = url.appending(path: path)
            
            var request = URLRequest(url: urlPath, timeoutInterval: Double.infinity)
            request.httpMethod = HttpMethod.get.rawValue
            request.addValue(RatesAPI.APIKey, forHTTPHeaderField: "apikey")
            
            return request
        }
    }
}
