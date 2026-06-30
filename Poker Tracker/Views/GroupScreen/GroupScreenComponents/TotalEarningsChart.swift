//
//  BarChart.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 31/10/2025.
//

import SwiftUI
import Charts

func formatMoney(double: Double) -> String {
    let Formatter = NumberFormatter()
    Formatter.numberStyle = .currency
    return Formatter.string(from: NSNumber(value: double)) ?? ""
}

struct TotalEarningsChart: View {
    @Binding var selectedYear: String
    @Binding var playerTotals: [PlayerTotals]
    
    @State var showedTotals: [PlayerTotals] = []
    
    private let barWidth: CGFloat = 60
    
    var body: some View {
        
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                Chart(showedTotals) { player in
                    BarMark(
                        x: .value("Player", player.name),
                        y: .value("Total", player.totalMoney)
                    )
                    .annotation(position: player.totalMoney >= 0 ? .top : .bottom) {
                        Text("\(formatMoney(double: player.totalMoney))")
                            .font(.system(size: 10))
                            .foregroundColor(.primary)
                    }
                    .foregroundStyle(player.totalMoney >= 0 ? .green : .red)
                }
                .frame(
                    width: max(UIScreen.main.bounds.width - 20,
                               CGFloat(showedTotals.count) * barWidth),
                    height: 250                )
                .padding(.horizontal, 10)
                .padding(.top, 10)
            }
        }
        .onAppear {
            updateData(for: selectedYear)
        }
        .onChange(of: selectedYear) {
            updateData(for: selectedYear)
        }
        .onChange(of: playerTotals) {
            updateData(for: selectedYear)
        }

    }
    
    
    private func updateData(for year: String) {
        
        showedTotals = filterYears(playerTotals: playerTotals, year: year)
        showedTotals = orderPlayerTotals(playerTotals: showedTotals)
    }
    
    
    private func filterYears(playerTotals: [PlayerTotals], year: String) -> [PlayerTotals] {
        if year == "All" {
            return playerTotals
        }
        else {
            return playerTotals
        }
    }
    
    private func orderPlayerTotals(playerTotals: [PlayerTotals]) -> [PlayerTotals] {
        return playerTotals.sorted { $0.totalMoney > $1.totalMoney }
    }
        
}

struct TotalEarningsChartPreview: View {
    
    @State var selectedYear: String = "2025"
    @State var playerTotals: [PlayerTotals] = [
            PlayerTotals(id: UUID(), name: "Bob", totalMoney: 20.0),
            PlayerTotals(id: UUID(), name: "bo", totalMoney: 10.0),
            PlayerTotals(id: UUID(), name: "Bo", totalMoney: -10.0),
            PlayerTotals(id: UUID(), name: "Bos", totalMoney: -10.0),
            PlayerTotals(id: UUID(), name: "Bod", totalMoney: -10.0),
            PlayerTotals(id: UUID(), name: "Bof", totalMoney: -10.0),
            PlayerTotals(id: UUID(), name: "Boe", totalMoney: -10.0),
            PlayerTotals(id: UUID(), name: "Boo", totalMoney: -10.0),
            PlayerTotals(id: UUID(), name: "Jimmy", totalMoney: -20.0)
        ]
    
    var body: some View {
        TotalEarningsChart(selectedYear: $selectedYear, playerTotals: $playerTotals)
    }
}

#Preview {
    TotalEarningsChartPreview()
}
