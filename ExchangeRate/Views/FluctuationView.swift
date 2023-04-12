//
//  FluctuationView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 06/04/23.
//

import SwiftUI

struct Fluctuation: Identifiable, Equatable {
    let id = UUID()
    var symbol: String
    var change: Double
    var changePct: Double
    var endRate: Double
}

class FluctuationViewModel: ObservableObject {
        
    @Published var searchText: String = ""
    @Published var color: Color = .purple
    
    @Published var periodSelected: PeriodSelected = .oneDay
        
    @Published var fluctuations: [Fluctuation] = [
        Fluctuation(symbol: "USD", change: 0.0008, changePct: 0.4892, endRate: 0.92389),
        Fluctuation(symbol: "EUR", change: 0.0003, changePct: 0.8923, endRate: 0.12390),
        Fluctuation(symbol: "BRL", change: -0.0010, changePct: -0.4892, endRate: 0.92389)
    ]
    
    func filterFluctuations(input: [Fluctuation]) -> [Fluctuation] {
        return fluctuations.filter {
            $0.symbol.contains(searchText.uppercased()) ||
            $0.change.formatter(decimalPlaces: 4).contains(searchText.uppercased()) ||
            $0.changePct.toPercentage().contains(searchText.uppercased()) ||
            $0.endRate.formatter(decimalPlaces: 2).contains(searchText.uppercased())
        }
    }
    
    
}

struct FluctuationView: View {
    
    @StateObject private var vm = FluctuationViewModel()
    
    @State private var isNegative: Bool = false
    @State private var isPresentedBaseCurrencyFilter: Bool = false
    @State private var isPresentedMultiCurrencyFilter: Bool = false
    
    var searchResult: [Fluctuation] {
        if vm.searchText.isEmpty {
            return vm.fluctuations
        } else {
            return vm.filterFluctuations(input: vm.fluctuations)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                baseCurrencyPeriodFilterView
                fluctuationList
            }
            .searchable(text: $vm.searchText)
            .navigationTitle("Conversão de moedas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        isPresentedMultiCurrencyFilter.toggle()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .sheet(isPresented: $isPresentedMultiCurrencyFilter) {
                        MultiCurrencyFilterView()
                    }
                }
            }
        }
    }
    
    private var baseCurrencyPeriodFilterView: some View {
        VStack {
            HStack(alignment: .center, spacing: 16) {
                SymbolButton(action: {
                    isPresentedBaseCurrencyFilter.toggle()
                }, title: "BRL", color: .white)
                .sheet(isPresented: $isPresentedBaseCurrencyFilter) {
                    BaseCurrencyView()
                }
                FluctuationPeriodButtons(selection: $vm.periodSelected)
            }
        }
    }
    
    private var fluctuationList: some View {
        List {
            ForEach(searchResult) { fluctuation in
                NavigationLink {
                    FluctuationDetailView(baseCurrency: "BRL", fluctuation: fluctuation)
                } label: {
                    FluctuationRowView(fluctuation: fluctuation)
                }
            }
        }
        .listStyle(.plain)
    }
}

struct FluctuationView_Previews: PreviewProvider {
    static var previews: some View {
        FluctuationView()
    }
}
