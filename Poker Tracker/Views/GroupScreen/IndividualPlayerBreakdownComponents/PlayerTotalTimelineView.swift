//
//  PlayerTotalTimelineView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 17/8/2026.
//

import SwiftUI
import Charts

struct PlayerTotalTimelineView: View {
    
    var dollarAmounts: [LinePoint]
    
    let barWidth: CGFloat = 90
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                Chart(Array(dollarAmounts.enumerated()), id: \.element.date) { index, amount in
                    LineMark(
                        x: .value("Index", index),
//                        x: .value("Date", formatDate(date: amount.date)),
                        y: .value("Amount", amount.value)
                        
                    )
                    .foregroundStyle(.blue)
                    PointMark(
                            x: .value("Index", index),
//                            x: .value("Date", formatDate(date: amount.date)),
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
                .chartXScale(
                    domain: 0...(dollarAmounts.count),
                    range: .plotDimension(padding: 10)
                )
                .frame(
                    width: max(
                        CGFloat(dollarAmounts.count) * barWidth,
                        UIScreen.main.bounds.width - barWidth
                    ),
                    height: 250
                )
                .padding(10)
                
//                .chartXAxis {
//                    AxisMarks(values: sortedAmounts.map { formatDate(date: $0.date) }) { value in
//                        AxisGridLine()
//                        AxisTick()
//                        AxisValueLabel {
//                            if let label = value.as(String.self) {
//                                Text(label)
//                            }
//                        }
//                    }
//                }
                
                .chartXAxis {
                    AxisMarks(values: Array(dollarAmounts.indices)) { value in
                        if let idx = value.as(Int.self) {
                            AxisGridLine()
                            AxisTick()
                            AxisValueLabel {
                                Text(formatDate(date: dollarAmounts[idx].date))
                            }
                        }
                    }
                }
                
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 24, style: .continuous).stroke(.white.opacity(0.25), lineWidth: 1)
                }
                .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 0)
                .padding(15)
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
    
    let calendar = Calendar.current
    let today = calendar.startOfDay(for: Date())
    let date: [Date] = (0..<5).map { offset in
        calendar.date(byAdding: .day, value: -offset, to: today)!
    }
    PlayerTotalTimelineView(
        dollarAmounts: [
            LinePoint(date: date[0], value: 0),
            LinePoint(date: date[1], value: 20),
            LinePoint(date: date[2], value: 30),
            LinePoint(date: date[3], value: 00),
            LinePoint(date: date[4], value: -10)
        ]
    )
}
