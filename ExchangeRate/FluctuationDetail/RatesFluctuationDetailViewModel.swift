//
//  RatesFluctuationDetailViewModel.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 20/06/23.
//

import Foundation
import SwiftUI

@MainActor
final class RatesFluctuationDetailViewModel: ObservableObject {
    
    @Published var ratesFluctuation: [RateFluctuation] = []
    @Published var historicalRates: [HistoricalRate] = []
    
    @Published var periodSelected: PeriodSelected = .oneDay
    
    @Published var timeRange: TimeRange = .today
    
    @Published var baseCurrency: String? = nil
    @Published var rateFluctuation: RateFluctuation?
    
    private var fluctuationDataProvider: FluctuationDataProvider?
    private var historicalDataProvider: TimeseriesDataProvider?
    
    init(fluctuationDataProvider: FluctuationDataProvider? = FluctuationDataProvider(),
         historicalDataProvider: TimeseriesDataProvider? = TimeseriesDataProvider()) {
        self.fluctuationDataProvider = fluctuationDataProvider
        self.fluctuationDataProvider?.delegate = self
        
        self.historicalDataProvider = historicalDataProvider
        self.historicalDataProvider?.delegate = self
    }
    
    var hasRates: Bool {
        return historicalRates.filter { $0.endRate > 0 }.count > 0
    }
    
    var yAxisMin: Double {
        let min = historicalRates.map { $0.endRate }.min() ?? 0.0
        return (min - (min * 0.02))
    }
    
    var yAxisMax: Double {
        let max = historicalRates.map { $0.endRate }.max() ?? 0.0
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
    
    var xAxisStride: Calendar.Component {
        switch timeRange {
        case .today:
            return .hour
        case .thisWeek:
            return .day
        case .thisMonth:
            return .day
        case .thisSemester:
            return .month
        case .thisYear:
            return .month
        }
    }
    
    var xAxisStrideCount: Int {
        switch timeRange {
        case .today:
            return 6
        case .thisWeek:
            return 2
        case .thisMonth:
            return 6
        case .thisSemester:
            return 2
        case .thisYear:
            return 3
        }
    }
    
    var symbol: String {
        return rateFluctuation?.symbol ?? ""
    }
    
    var title: String {
        return "\(baseCurrency ?? "-") a \(symbol)"
    }
    
    var endRate: Double {
        return rateFluctuation?.endRate ?? 0.0
    }
    
    var changePct: Double {
        rateFluctuation?.changePct ?? 0.0
    }
    
    var change: Double {
        return rateFluctuation?.change ?? 0.0
    }
    
    var changeDescription: String {
        switch timeRange {
        case .today:
            return "\(change.formatter(decimalPlaces: 4, changeSymbol: true)) (1 dia)"
            
        case .thisWeek:
            return "\(change.formatter(decimalPlaces: 4, changeSymbol: true)) (7 dias)"
        case .thisMonth:
            return "\(change.formatter(decimalPlaces: 4, changeSymbol: true)) (1 mês)"
        case .thisSemester:
            return "\(change.formatter(decimalPlaces: 4, changeSymbol: true)) (6 meses)"
        case .thisYear:
            return "\(change.formatter(decimalPlaces: 4, changeSymbol: true)) (1 ano)"
        }
    }
    
    func startStateView(baseCurrency: String, rateFluctuation: RateFluctuation, timeRange: TimeRange) {
        self.baseCurrency = baseCurrency
        self.rateFluctuation = rateFluctuation
        doFetchData(from: timeRange)
    }
    
    func doFetchData(from timeRange: TimeRange) {
        ratesFluctuation.removeAll()
        historicalRates.removeAll()
        
        withAnimation {
            self.timeRange = timeRange
        }
        
        doFetchRatesFluctuation()
        doFetchHistoricalRates(by: symbol)
    }
    
    func doFilter(by currency: String) {
        if let rateFluctuation = ratesFluctuation.filter({ $0.symbol == currency }).first {
            self.rateFluctuation = rateFluctuation
            doFetchHistoricalRates(by: rateFluctuation.symbol)
        }
    }
    
    func doFetchComparation(with rateFluctuation: RateFluctuation) {
        self.rateFluctuation = rateFluctuation
        doFetchHistoricalRates(by: rateFluctuation.symbol)
    }
    
    private func doFetchRatesFluctuation() {
        if let baseCurrency {
            let startDate = timeRange.date.toString()
            let endDate = Date().toString()
            fluctuationDataProvider?.fetchFluctuation(base: baseCurrency, symbols: [], startDate: startDate, endDate: endDate)
        }
    }
    
    private func doFetchHistoricalRates(by currency: String) {
        if let baseCurrency {
            let startDate = timeRange.date.toString()
            let endDate = Date().toString()
            historicalDataProvider?.fetchTimeseries(base: baseCurrency, symbol: currency, startDate: startDate, endDate: endDate)
        }
    }
}

extension RatesFluctuationDetailViewModel: TimeseriesDataProviderDelegate, FluctuationDataProviderDelegate {
    
    func success(model: [HistoricalRate]) {
        DispatchQueue.main.async {
            self.historicalRates = model.sorted { $0.period > $1.period }
        }
    }
    
    func success(model: [RateFluctuation]) {
        DispatchQueue.main.async {
            self.rateFluctuation = model.filter({ rate in
                return rate.symbol == self.symbol
            }).first
            self.ratesFluctuation = model.filter({ $0.symbol != self.baseCurrency}).sorted { $0.symbol < $1.symbol }
            
        }
    }
}
