//
//  BaseCurrencyView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 12/04/23.
//

import SwiftUI

protocol BaseCurrencyViewDelegate {
    func didSelected(_ baseCurrency: String)
}
 
struct BaseCurrencyFilterView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel = BaseCurrencyViewModel()
    
    @State private var selection: String? = ""
    @State private var searchText: String = ""
    
    var delegate: BaseCurrencyViewDelegate?
    
    var searchResults: [CurrencySymbol] {
        if searchText.isEmpty {
            return viewModel.currencySymbols
        } else {
            return viewModel.currencySymbols.filter({
                $0.symbol.contains(searchText.uppercased()) ||
                $0.fullName.contains(searchText.uppercased())
            })
        }
    }
    
    var body: some View {
        NavigationStack {
            currenciesListView
        }
        .onAppear {
            viewModel.doFetchCurrencySymbols()
        }
    }
    
    private var currenciesListView: some View {
        List(searchResults, id: \.symbol, selection: $selection) { item in
            HStack {
                Text(item.symbol)
                Text("-")
                Text(item.fullName)
            }
            .font(.callout)
            .fontWeight(.semibold)
        }
        .listStyle(.plain)
        .searchable(text: $searchText)
        .navigationTitle("Filtrar moedas")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if let selection {
                        delegate?.didSelected(selection)
                    }
                    self.dismiss()
                } label: {
                    Text("OK")
                        .bold()
                }
            }
        }
    }
}

struct BaseCurrencyFilterView_Previews: PreviewProvider {
    static var previews: some View {
        BaseCurrencyFilterView()
    }
}
