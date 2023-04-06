//
//  StoreProtocol.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 06/04/23.
//

import Foundation

protocol StoreProtocol {
    func handleResponse<T: Codable>(urlRequest: URLRequest, body: T.Type) async throws -> T
}

extension StoreProtocol {
    
    func handleResponse<T: Codable>(urlRequest: URLRequest, body: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard data == data,
              let response = response as? HTTPURLResponse,
              (200 ..< 300) ~= response.statusCode else {
            print("BAR URL GERAL")
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
