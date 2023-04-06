//
//  ContentView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 05/04/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Button {
                doFetchData()
            } label: {
                Image(systemName: "plus")
            }

        }
        .padding()
    }
    
    private func doFetchData() {
        let fluctuationDataProvider = FluctuationDataProvider()
        fluctuationDataProvider.delegate = self
        fluctuationDataProvider.fetchFluctuation(base: "BRL", symbols: ["USD", "EUR"], startDate: "2022-10-11", endDate: "2022-11-11")
        
        let timeseriesDataProvider = TimeseriesDataProvider()
        timeseriesDataProvider.delegate = self
        timeseriesDataProvider.fetchTimeseries(base: "BRL", symbols: ["USD", "EUR"], startDate: "2022-10-11", endDate: "2022-11-11")
        
        let symbolsDataProvider = SymbolsDataProvider()
        symbolsDataProvider.delegate = self
        symbolsDataProvider.fetchSymbols()
    }
}

extension ContentView: FluctuationDataProviderDelegate {
    func success(model: FluctuationResponse) {
        print("FLUCTUATION: \(model)\n\n")
    }
}

extension ContentView: TimeseriesDataProviderDelegate {
    func success(model: TimeseriesResponse) {
        print("TIMESERIES: \(model)\n\n")

    }
}

extension ContentView: SymbolsDataProviderDelegate {
    func success(model: SymbolsResponse) {
        print("SYMBOLS: \(model)\n\n")

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
