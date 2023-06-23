//
//  FluctuationDetailView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 11/04/23.
//

import SwiftUI
import Charts

struct RatesFluctuationDetailView: View {
    
    @StateObject var vm = RatesFluctuationDetailViewModel()
    
    @State var baseCurrency: String
    @State private var isPresentedMultiCurrencyFilter: Bool = false
    
    //model
    @State var fluctuation: RateFluctuation
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                valuesView
                graphicChartView
            }
            .padding()
            .navigationTitle(vm.title)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                vm.startStateView(baseCurrency: baseCurrency, rateFluctuation: fluctuation, timeRange: .today)
            }
        }
    }
    
    private var valuesView: some View {
        HStack(alignment: .center, spacing: 18) {
            Text(vm.endRate.formatter(decimalPlaces: 4))
                .font(.system(size: 28, weight: .bold))
            Text(vm.change.toPercentage(changeSymbol: true))
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(vm.change.color)
                .padding(8)
                .background(vm.change.color.opacity(0.2))
                .cornerRadius(10)
            Text(vm.changeDescription)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(vm.change.color)
        }
        .frame(height: 40)
        .frame(maxWidth: .infinity)
    }
    
    private var graphicChartView: some View {
        VStack {
            periodFilterView
            FluctuationDetailChartView(vm: vm)
            comparationView
        }
    }
    
    private var periodFilterView: some View {
        HStack(alignment: .center, spacing: 16) {
            SymbolButton(action: {
                isPresentedMultiCurrencyFilter.toggle()
            }, title: $vm.baseCurrency, color: .white)
            .sheet(isPresented: $isPresentedMultiCurrencyFilter) {
                BaseCurrencyFilterView()
            }
            FluctuationDetailPeriodButton(selection: $vm.periodSelected, vm: vm)
        }
        .padding(.vertical)
    }
    
    private var comparationView: some View {
        VStack {
            comparationButtonView
            comparationScrollView
        }
    }
    
    private var comparationButtonView: some View {
        HStack {
            Button {
                isPresentedMultiCurrencyFilter.toggle()
            } label: {
                Image(systemName: "magnifyingglass")
                Text("Comparar com")
                    .font(.callout)
                    .bold()
            }
            .sheet(isPresented: $isPresentedMultiCurrencyFilter) {
                BaseCurrencyFilterView(delegate: self)
            }
        }
    }

    private var comparationScrollView: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(
                    rows: [GridItem(.flexible())],
                    alignment: .center,
                    spacing: 10,
                    pinnedViews: .sectionFooters) {
                        ForEach(vm.ratesFluctuation) { fluctuation in
                            Button {
                                vm.doFetchComparation(with: fluctuation)
                            } label: {
                                FluctuationDetailGridButtonView(fluctuation: fluctuation, baseCurrency: $baseCurrency)
                            }
                        }
                    }
            }
            .frame(height: 115)
            .frame(maxWidth: .infinity)
        }
    }
}

extension RatesFluctuationDetailView: BaseCurrencyViewDelegate {
    
    func didSelected(_ baseCurrency: String) {
        vm.doFilter(by: baseCurrency)
    }
}

struct FluctuationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RatesFluctuationDetailView(baseCurrency: "USD", fluctuation: RateFluctuation(symbol: "JPY", change: 0.0008, changePct: 0.0005, endRate: 0.007272))
    }
}
