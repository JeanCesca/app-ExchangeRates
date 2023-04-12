//
//  CurrencySelectionFilterView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 12/04/23.
//

import SwiftUI

class CurrencySelectionFilterViewModel: ObservableObject {
    
    @Published var symbols: [Symbol] = [
        Symbol(symbol: "BRL", fullName: "Brazilian Real"),
        Symbol(symbol: "EUR", fullName: "Euro"),
        Symbol(symbol: "GBP", fullName: "British Pound Sterling"),
        Symbol(symbol: "JPY", fullName: "Japanese Yen"),
        Symbol(symbol: "USD", fullName: "United States Dollar")
    ]
    
}

struct MultiCurrencyFilterView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var vm = CurrencySelectionFilterViewModel()
    
    @State private var searchText: String = ""
    @State private var selections: [String] = []
    
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
                Button {
                    if selections.contains(item.symbol) {
                        selections.removeAll(where: { $0 == item.symbol })
                    } else {
                        selections.append(item.symbol)
                    }
                } label: {
                    HStack {
                        HStack {
                            Text(item.symbol)
                            Text("-")
                            Text(item.fullName)
                        }
                        .font(.callout)
                        .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: "checkmark")
                            .opacity(
                                selections.contains(item.symbol) ? 1.0 : 0.0
                            )
                    }
                }
                .foregroundColor(.primary)

            }
        }
        .listStyle(.plain)
        .searchable(text: $searchText)
        .navigationTitle("Selecione moedas para filtrar")
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

struct MultiCurrencyFilterView_Previews: PreviewProvider {
    static var previews: some View {
        MultiCurrencyFilterView()
    }
}
