//
//  DataProviderManager.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 05/04/23.
//

import Foundation

protocol DataProviderManagerDelegate {
    func success(model: Any)
    func errorData(provider: DataProviderManagerDelegate?, error: Error)
}

extension DataProviderManagerDelegate {

    func success(model: Any) {
        preconditionFailure("This method must be overridden.")
    }

    func errorData(provider: DataProviderManagerDelegate?, error: Error) {
        print("Erro no timeseries dataprovider: \(error)")
        print(error.localizedDescription)
    }
}

class DataProviderManager<T, S> {
    var delegate: T?
    var model: S?
}
