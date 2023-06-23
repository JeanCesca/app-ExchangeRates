//
//  FluctuationChartView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 11/04/23.
//

import SwiftUI
import Charts

struct FluctuationDetailChartView: View {
    
    @StateObject var vm: RatesFluctuationDetailViewModel
    
    var body: some View {
        lineChartView
    }
    
    private var lineChartView: some View {
        Chart(vm.historicalRates) { item in
            LineMark(
                x: .value("Período", item.period),
                y: .value("Taxas", item.endRate))
            .interpolationMethod(.catmullRom)
            
            if !vm.hasRates {
                RuleMark(
                    y: .value("Conversão Zero", 0)
                )
                .annotation(position: .overlay, alignment: .center) {
                    Text("Sem valores nesse período")
                        .font(.footnote)
                        .padding()
                        .background(
                            Color(uiColor: .systemBackground)
                        )
                }
            }
        }
        .chartXAxis(content: {
            AxisMarks(preset: .aligned, values: .stride(by: vm.xAxisStride, count: vm.xAxisStrideCount)) { date in
                AxisGridLine()
                AxisValueLabel(vm.xAxisLabelFormatStyle(for: date.as(Date.self) ?? Date()))
            }
        })
        .chartYAxis(content: {
            AxisMarks(position: .leading) { rate in
                AxisGridLine()
                AxisValueLabel(rate.as(Double.self)?.formatter(decimalPlaces: 3) ?? "")
            }
        })
        .chartYScale(domain: vm.yAxisMin...vm.yAxisMax)
        .padding(.trailing, 14)
        .frame(height: 260)
    }
}

struct FluctuationDetailChartView_Previews: PreviewProvider {
    static var previews: some View {
        FluctuationDetailChartView(vm: RatesFluctuationDetailViewModel())
    }
}
