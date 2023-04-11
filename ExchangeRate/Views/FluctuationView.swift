//
//  FluctuationView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 06/04/23.
//

import SwiftUI

struct Fluctuation: Identifiable {
    let id = UUID()
    var symbol: String
    var change: Double
    var changePct: Double
    var endRate: Double

}

class FluctuationViewModel: ObservableObject {
    
    @Published var searchText: String = ""
        
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
                listHeader
                fluctuationList
            }
            .searchable(text: $vm.searchText)
            .navigationTitle("Conversão de moedas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        print("Filtrar moedas")
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
    }
    
    private var baseCurrencyPeriodFilterView: some View {
        HStack(alignment: .center, spacing: 16) {
            ButtonView(action: {
                print("Filtrar moeda base")
            }, title: "BRL", color: .white, font: .callout, isUnderline: false)
            
            ButtonView(action: {
                print("Filtrar moeda base")
            }, title: "1 dia", color: .accentColor, font: .callout, isUnderline: true)
            
            ButtonView(action: {
                
            }, title: "7 dias", color: .secondary, font: .callout, isUnderline: true)
            
            ButtonView(action: {
                
            }, title: "1 mês", color: .secondary, font: .callout, isUnderline: true)
            
            ButtonView(action: {
                
            }, title: "6 meses", color: .secondary, font: .callout, isUnderline: true)
            
            ButtonView(action: {
                
            }, title: "1 ano", color: .secondary, font: .callout, isUnderline: true)

        }
    }
    
    private var listHeader: some View {
        HStack {
            Text("SYMBOL")
            Spacer()
            Spacer()
            Text("EndRate")
            Spacer()
            Text("Change")
            Spacer()
            Text("ChangePct")
        }
        .padding()
        .font(.callout)
        .fontWeight(.regular)
    }
    
    private var fluctuationList: some View {
        List {
            ForEach(searchResult) { data in
                HStack {
                    
                    Text("\(data.symbol) / BRL")
                        .font(.headline)
                        .bold()
                        .fontWeight(.regular)
                    
                    Spacer()
                    Spacer()
                    Spacer()

                    Text(data.endRate.formatter(decimalPlaces: 2))
                        .font(.callout)
                        .bold()
                    
                    Spacer()
 
                    Text(data.change.formatter(decimalPlaces: 4, changeSymbol: true))
                        .font(.callout)
                        .bold()
                        .foregroundColor(data.change.color)

                    Spacer()

                    Text("(\(data.changePct.toPercentage(changeSymbol: true)))")
                        .font(.callout)
                        .bold()
                        .foregroundColor(data.changePct.color)
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
