//
//  CurrencySelectionFilterView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 12/04/23.
//

import SwiftUI

protocol MultiCurrencyFilterViewDelegate {
    func didSelected(_ currencies: [String])
}

struct MultiCurrencyFilterView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var vm = MultiCurrencyFilterViewModel()
    
    @State private var searchText: String = ""
    @State private var selections: [String] = []
    
    var delegate: MultiCurrencyFilterViewDelegate?
    
    var searchResults: [CurrencySymbol] {
        if searchText.isEmpty {
            return vm.currencySymbols
        } else {
            return vm.currencySymbols.filter({
                $0.symbol.contains(searchText.uppercased()) ||
                $0.symbol.contains(searchText.uppercased())
            })
        }
    }
    
    var body: some View {
        NavigationStack {
            currenciesListView
        }
        .onAppear {
            vm.doFetchMultiCurrencySymbols()
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
                    self.delegate?.didSelected(selections)
                    self.dismiss()
                } label: {
                    Text(
                        selections.isEmpty ? "Cancelar" : "OK"
                    )
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
