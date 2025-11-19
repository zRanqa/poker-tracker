//
//  ShowOtherStats.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 31/10/2025.
//

import SwiftUI

func formatPercentage(amount: Double) -> String {
    return String(format: "%.0f%%", amount)
}

struct ShowOtherStats: View {
    
    @State var nightEntries: [NightEntry] = []
    @State var playerTotals: [PlayerTotals] = []
    
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Other Stats:")
                    .foregroundStyle(.orange)
                    .font(.system(size: 25))
                Spacer()
            }
            
            VStack(spacing: 15) {
                
                VStack {
                    HStack {
                        Text("💯 Current Highest Win Percentage:")
                        Spacer()
                    }
                    HStack {
                        Text("💯 \(getBiggestWinPercentage()?.playerDetails.name ?? "Loading") — \(formatPercentage(amount: getBiggestWinPercentage()?.winPercentage ?? 0))")
                        Spacer()
                    }
                }
                
                VStack {
                    HStack {
                        Text("🏆 Current Longest Winstreak:")
                        Spacer()
                    }
                    HStack {
                        Text("🔥 \(getBiggestWinStreak()?.playerDetails.name ?? "Loading") — \(getBiggestWinStreak()?.winStreak ?? 0)")
                        Spacer()
                    }
                }
                
                
                VStack {
                    HStack {
                        Text("📉 Current Longest Loss Streak:")
                        Spacer()
                    }
                    HStack {
                        Text("😢 \(getBiggestLossStreak()?.playerDetails.name ?? "Loading") — \(getBiggestLossStreak()?.lossStreak ?? 0)")
                        Spacer()
                    }
                }
                
                VStack {
                    HStack {
                        Text("🏦 Most Buy-Ins:")
                        Spacer()
                    }
                    HStack {
                        Text("💸 \(getMostBuyIns()?.playerDetails.name ?? "Loading") — \(getMostBuyIns()?.buyIns ?? 0)")
                        Spacer()
                    }
                }
                
                VStack {
                    HStack {
                        Text("💰 Most Money Won In A Night:")
                        Spacer()
                    }
                    HStack {
                        Text("🤑 \(getMostMoney()?.playerDetails.name ?? "Loading") — \(formatAmount(amount: getMostMoney()?.mostMoneyWon ?? 0))")
                        Spacer()
                    }
                }
                
                VStack {
                    HStack {
                        Text("🔻 Most Money Lost In A Night:")
                        Spacer()
                    }
                    HStack {
                        Text("💀 \(getMostLostMoney()?.playerDetails.name ?? "Loading") — \(formatAmount(amount: getMostLostMoney()?.mostMoneyLost ?? 0))")
                        Spacer()
                    }
                }
                
            }
            
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
            
            // Biggest win streak
            // Biggest loss streak
            // Most buy ins
            // Most money won in night
            // Most money lost in night

            
            
        }
        .onAppear() {
            Task {
                nightEntries = try await loadAllNightEntries()
                playerTotals = await calculateTotals()
            }
        }
        .padding(.horizontal, 20)
    }
    
    private func getBiggestWinStreak() -> PlayerTotals? {
        return playerTotals.sorted(by: { $0.winStreak > $1.winStreak }).first
    }
    
    private func getBiggestLossStreak() -> PlayerTotals? {
        return playerTotals.sorted(by: { $0.lossStreak > $1.lossStreak }).first
    }
    
    private func getMostBuyIns() -> PlayerTotals? {
        return playerTotals.sorted(by: { $0.buyIns > $1.buyIns }).first
    }
    
    private func getMostMoney() -> PlayerTotals? {
        return playerTotals.sorted(by: { $0.mostMoneyWon > $1.mostMoneyWon }).first
    }
    
    private func getMostLostMoney() -> PlayerTotals? {
        return playerTotals.sorted(by: { $0.mostMoneyLost < $1.mostMoneyLost }).first
    }
    
    private func getBiggestWinPercentage() -> PlayerTotals? {
        return playerTotals.sorted(by: { $0.winPercentage > $1.winPercentage }).first
    }
    
}

#Preview {
    ShowOtherStats()
}
