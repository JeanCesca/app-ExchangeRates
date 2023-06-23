//
//  FluctuationView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 06/04/23.
//

import SwiftUI

struct RatesFluctuationView: View {
    
    @StateObject private var vm = RatesFluctuationViewModel()
    @State private var viewDidLoad: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack {
                baseCurrencyPeriodFilterView
                RatesFluctuationRowTitleView()
                    .padding(.horizontal, 20)
                
                ratesFluctuationList
            }
            .searchable(text: $vm.searchText)
            .navigationTitle("Conversão de moedas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        vm.isPresentedMultiCurrencyFilter.toggle()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .sheet(isPresented: $vm.isPresentedMultiCurrencyFilter) {
                        MultiCurrencyFilterView(delegate: self)
                    }
                }
            }
        }
        .onAppear {
            if viewDidLoad {
                viewDidLoad.toggle()
                vm.doFetchRatesFluctuation(timeRange: .today)
            }
        }
    }
    
    private var baseCurrencyPeriodFilterView: some View {
        VStack {
            HStack(alignment: .center, spacing: 16) {
                SymbolButton(action: {
                    vm.isPresentedBaseCurrencyFilter.toggle()
                }, title: $vm.baseCurrency, color: .white)
                .sheet(isPresented: $vm.isPresentedBaseCurrencyFilter) {
                    BaseCurrencyFilterView(delegate: self)
                }
                RatesFluctuationPeriodButtons(
                    selection: $vm.periodSelected,
                    vm: vm)
            }
        }
    }
    
    private var ratesFluctuationList: some View {
        List {
            ForEach(vm.searchResult) { fluctuation in
                NavigationLink {
                    RatesFluctuationDetailView(baseCurrency: vm.baseCurrency ?? "", fluctuation: fluctuation)
                } label: {
                    RatesFluctuationRowView(vm: vm, fluctuation: fluctuation)
                }
            }
        }
        .listStyle(.plain)
    }
}

extension RatesFluctuationView: BaseCurrencyViewDelegate {
    
    func didSelected(_ baseCurrency: String) {
        vm.baseCurrency = baseCurrency
        print(baseCurrency)
        vm.doFetchRatesFluctuation(timeRange: .today)
    }
}

extension RatesFluctuationView: MultiCurrencyFilterViewDelegate {
    
    func didSelected(_ currencies: [String]) {
        vm.currencies = currencies
        vm.doFetchRatesFluctuation(timeRange: .today)
    }
}

struct RatesFluctuationView_Previews: PreviewProvider {
    static var previews: some View {
        RatesFluctuationView()
    }
}
