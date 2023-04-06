//
//  SymbolStore.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 05/04/23.
//

import Foundation

protocol SymbolStoreProtocol {
    func fetchSymbols() async throws -> SymbolsResponse
}

class SymbolStore: SymbolStoreProtocol, StoreProtocol {
    
    func fetchSymbols() async throws -> SymbolsResponse {
        guard let urlRequest = try SymbolsRouter.symbols.asUrlRequest() else {
            print("SERVIDOR RUIM: SYMBOL")
            throw URLError(.badURL)
        }
        
        return try await handleResponse(urlRequest: urlRequest, body: SymbolsResponse.self)
    }
}
