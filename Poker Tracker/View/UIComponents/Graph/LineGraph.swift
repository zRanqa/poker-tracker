//
//  LineGraph.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 20/11/2025.
//

import SwiftUI
import Charts


struct LineGraph: View {
    
    var dollarAmounts: [LinePoint]
    
    let barWidth: CGFloat = 80
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                Chart(Array(dollarAmounts.enumerated()), id: \.1.id) { index, amount in
                    LineMark(
                        x: .value("Index", index),
                        y: .value("Amount", amount.value)
                        
                    )
                    .foregroundStyle(.blue)
                    PointMark(
                            x: .value("Index", index),
                            y: .value("Amount", amount.value)
                        )
                        .symbol(Circle())
                        .foregroundStyle(getColorFromValue(value: amount.value))
                        .annotation(position: .top) {
                            Text("$\(amount.value, specifier: "%.2f")")
                                .font(.caption)
                                .foregroundColor(getColorFromValue(value: amount.value))
                        }
                }
                .frame(
                    width: max(CGFloat(dollarAmounts.count) * barWidth, UIScreen.main.bounds.width - 20),
                    height: 300
                )
                .chartXAxis {
                    AxisMarks(values: Array(dollarAmounts.indices)) { value in
                        if let idx = value.as(Int.self) {
                            AxisValueLabel {
                                Text(formatDateMedium(date: dollarAmounts[idx].date))
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
    private func getColorFromValue(value: Double) -> Color {
        if value > 0 {
            return .green
        }
        if value < 0 {
            return .red
        }
        else {
            return .primary
        }
    }
}

#Preview {
    let now = Date()
    var dollarAmounts = (0..<3).map { i in
        LinePoint(
            date: Calendar.current.date(byAdding: .day, value: i, to: now)!,
            value: Double((i) * 100)
        )
    }
    dollarAmounts.append(LinePoint(date: now, value: 0))
    dollarAmounts.append(LinePoint(date: now, value: -100))

    return LineGraph(dollarAmounts: dollarAmounts)
}
