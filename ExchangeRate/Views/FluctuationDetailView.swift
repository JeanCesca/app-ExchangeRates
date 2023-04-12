//
//  FluctuationDetailView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 11/04/23.
//

import SwiftUI
import Charts

struct ChartComparation: Identifiable, Equatable {
    let id = UUID()
    var symbol: String
    var period: Date
    var endRate: Double
}

class FluctuationDetailViewModel: ObservableObject {
    
    @Published var fluctuations: [Fluctuation] = [
        Fluctuation(symbol: "JPY", change: 0.0008, changePct: 0.0005, endRate: 0.007272),
        Fluctuation(symbol: "EUR", change: 0.0003, changePct: 0.8932, endRate: 0.001272),
        Fluctuation(symbol: "GBPT", change: -0.0008, changePct: -0.9032, endRate: 0.233272)
    ]
    
    @Published var chartComparations: [ChartComparation] = [
        ChartComparation(symbol: "USD", period: "2022-11-13".toDate(), endRate: 0.18857),
        ChartComparation(symbol: "USD", period: "2022-11-12".toDate(), endRate: 0.28857),
        ChartComparation(symbol: "USD", period: "2022-11-11".toDate(), endRate: 0.18857),
        ChartComparation(symbol: "USD", period: "2022-11-10".toDate(), endRate: 0.48857)
    ]
    
    @Published var timeRange: TimeRange = .today
    
    var hasRates: Bool {
        return chartComparations.filter { $0.endRate > 0 }.count > 0
    }
    
    var yAxisMin: Double {
        let min = chartComparations.map { $0.endRate }.min() ?? 0.0
        return (min - (min * 0.02))
    }
    
    var yAxisMax: Double {
        let max = chartComparations.map { $0.endRate }.max() ?? 0.0
        return (max + (max * 0.02))
    }
    
    func xAxisLabelFormatStyle(for date: Date) -> String {
        switch timeRange {
        case .today:
            return date.formatter(to: "HH:mm")
        case .thisWeek:
            return date.formatter(to: "dd, MM")
        case .thisMonth:
            return date.formatter(to: "MMM")
        case .thisSemester:
            return date.formatter(to: "MMM")
        case .thisYear:
            return date.formatter(to: "MMM, YYYY")
        }
    }
}

struct FluctuationDetailView: View {
    
    @StateObject var vm = FluctuationDetailViewModel()
    
    @State var baseCurrency: String
    @State private var isPresentedMultiCurrencyFilter: Bool = false
    
    //model
    @State var fluctuation: Fluctuation
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                valuesView
                graphicChartView
            }
            .padding()
            .navigationTitle("Conversão de BRL para USD")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var valuesView: some View {
        HStack(alignment: .center, spacing: 18) {
            Text(fluctuation.endRate.formatter(decimalPlaces: 4))
                .font(.system(size: 28, weight: .bold))
            Text(fluctuation.change.toPercentage(changeSymbol: true))
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(fluctuation.change.color)
                .padding(8)
                .background(fluctuation.change.color.opacity(0.2))
                .cornerRadius(10)
            Text(fluctuation.change.formatter(decimalPlaces: 4, changeSymbol: true))
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(fluctuation.change.color)
        }
        .frame(height: 40)
        .frame(maxWidth: .infinity)
    }
    
    private var graphicChartView: some View {
        VStack {
            periodFilterView
            FluctuationChartView(vm: vm)
            comparationView
        }
    }
    
    private var periodFilterView: some View {
        HStack(alignment: .center, spacing: 16) {

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
                BaseCurrencyView()
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
                        ForEach(vm.fluctuations) { fluctuation in
                            Button {
                                
                            } label: {
                                ComparationGridButtonView(fluctuation: fluctuation, baseCurrency: $baseCurrency)
                            }
                        }
                    }
            }
            .frame(height: 115)
            .frame(maxWidth: .infinity)
        }
    }
}

struct FluctuationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FluctuationDetailView(baseCurrency: "USD", fluctuation: Fluctuation(symbol: "JPY", change: 0.0008, changePct: 0.0005, endRate: 0.007272))
    }
}
