//
//  BarChart.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 31/10/2025.
//

import SwiftUI
import Charts

struct TotalEarningsChart: View {
    var fullscreen: Bool
    var onTap: () -> Void
    
    @State var playerTotals: [PlayerTotals] = []
    @State var showedTotals: [PlayerTotals] = []
    @State var showOneTimers: Bool = false
    
    
    private var barWidth: CGFloat = 60
    
    init(fullscreen: Bool = false, onTap: @escaping () -> Void = {}) {
        self.fullscreen = fullscreen
        self.onTap = onTap
    }
    
    var body: some View {
        
        if fullscreen {
            VStack {
                Chart(showedTotals) { player in
                    BarMark(
                        x: .value("Player", player.playerDetails.name),
                        y: .value("Total", player.totalMoney)
                    )
                    .annotation(position: player.totalMoney >= 0 ? .top : .bottom) {
                        
                        Text("\(formatAmount(amount: player.totalMoney))")
                            .font(.system(size: 10))
                            .foregroundColor(.primary)
                        
                    }
                    .foregroundStyle(player.totalMoney >= 0 ? .green : .red)
                }
                .frame(width: 700, height: 300)
                .padding()
                
                .onAppear {
                    Task {
                        playerTotals = await calculateTotals()
                        showedTotals = nonOneTimePlayers()
                    }
                }
                HStack {
                    
                    Button(action: {
                        onTap()
                    }) {
                        Text("Back")
                            .padding(10)
                            .foregroundStyle(.orange)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                    }
                    Spacer()
                    
                    Button(action: {
                        showOneTimers.toggle()
                        if showOneTimers {
                            showedTotals = oneTimePlayers()
                        }
                        else {
                            showedTotals = nonOneTimePlayers()
                        }
                    }) {
                        Text(showOneTimers ? "Show Non-One Timers" : "Show One Timers")
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .foregroundStyle(.orange)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                        
                    }
                    .padding(.horizontal, 20)
                }
            }
            .rotationEffect(fullscreen ? .degrees(90) : .zero)
        }
        else {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    Chart(showedTotals) { player in
                        BarMark(
                            x: .value("Player", player.playerDetails.name),
                            y: .value("Total", player.totalMoney)
                        )
                        .annotation(position: player.totalMoney >= 0 ? .top : .bottom) {
                            
                            Text("\(formatAmount(amount: player.totalMoney))")
                                .font(.system(size: 10))
                                .foregroundColor(.primary)
                            
                        }
                        .foregroundStyle(player.totalMoney >= 0 ? .green : .red)
                    }
                    .frame(width: (CGFloat(showedTotals.count) * barWidth), height: 400)
                    .padding(.bottom, 0)
                    .padding()
                }
                .onAppear {
                    Task {
                        playerTotals = await calculateTotals()
                        showedTotals = nonOneTimePlayers()
                    }
                }
                
                Button(action: {
                    showOneTimers.toggle()
                    if showOneTimers {
                        showedTotals = oneTimePlayers()
                    }
                    else {
                        showedTotals = nonOneTimePlayers()
                    }
                }) {
                    Text(showOneTimers ? "Show Non-One Timers" : "Show One Timers")
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .foregroundStyle(.orange)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                    
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    private func oneTimePlayers() -> [PlayerTotals] {
        return orderPlayerTotals(playerTotals: playerTotals)
    }
    
    private func nonOneTimePlayers() -> [PlayerTotals] {
        return orderPlayerTotals(playerTotals: playerTotals.filter { $0.totalGames > 1 })
    }
    
    private func orderPlayerTotals(playerTotals: [PlayerTotals]) -> [PlayerTotals] {
        return playerTotals.sorted { $0.totalMoney > $1.totalMoney }
    }
        
}

#Preview {
    TotalEarningsChart(fullscreen: true, onTap: { print("yes") })
}
