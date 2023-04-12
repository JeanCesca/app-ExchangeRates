//
//  FluctuationChartView.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 11/04/23.
//

import SwiftUI
import Charts

struct FluctuationChartView: View {
    
    @StateObject var vm: FluctuationDetailViewModel
    
    var body: some View {
        lineChartView
    }
    
    private var lineChartView: some View {
        Chart(vm.chartComparations) { item in
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
            AxisMarks(preset: .aligned) { date in
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

struct FluctuationChartView_Previews: PreviewProvider {
    static var previews: some View {
        FluctuationChartView(vm: FluctuationDetailViewModel())
    }
}
