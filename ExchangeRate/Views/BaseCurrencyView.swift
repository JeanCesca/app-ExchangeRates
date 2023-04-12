//
//  BaseCurrencyView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 12/04/23.
//

import SwiftUI

struct Symbol: Identifiable, Equatable {
    let id = UUID()
    var symbol: String
    var fullName: String
}

class BaseCurrencyViewModel: ObservableObject {
    
    @Published var symbols: [Symbol] = [
        Symbol(symbol: "BRL", fullName: "Brazilian Real"),
        Symbol(symbol: "EUR", fullName: "Euro"),
        Symbol(symbol: "GBP", fullName: "British Pound Sterling"),
        Symbol(symbol: "JPY", fullName: "Japanese Yen"),
        Symbol(symbol: "USD", fullName: "United States Dollar")
    ]

    func filter() -> [Symbol] {
        let teste = symbols.filter({$0.fullName.hasPrefix("B")})
        return teste
    }
}
 
struct BaseCurrencyView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var vm = BaseCurrencyViewModel()
    
    @State private var selection: String?
    @State private var searchText: String = ""
    
    var searchResults: [Symbol] {
        if searchText.isEmpty {
            return vm.symbols
        } else {
            return vm.symbols.filter({
                $0.symbol.contains(searchText.uppercased()) ||
                $0.fullName.contains(searchText.uppercased())
            })
        }
    }
    
    var body: some View {
        NavigationStack {
            currenciesListView
        }
    }
    
    private var currenciesListView: some View {
        List {
            ForEach(searchResults, id: \.id) { item in
                HStack {
                    Text(item.symbol)
                    Text("-")
                    Text(item.fullName)
                }
                .font(.callout)
                .fontWeight(.semibold)
            }
        }
        .listStyle(.plain)
        .searchable(text: $searchText)
        .navigationTitle("Filtrar moedas")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.dismiss()
                } label: {
                    Text("OK")
                        .bold()
                }

            }
        }
    }
}

struct BaseCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        BaseCurrencyView()
    }
}
