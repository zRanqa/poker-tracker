//
//  ShowOtherStats.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 31/10/2025.
//

import SwiftUI

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
                        Text("🔥 Current Longest Winstreak:")
                        Spacer()
                    }
                    HStack {
                        Text("🏆 \(getBiggestWinStreak()?.playerDetails.name ?? "Loading") — \(getBiggestWinStreak()?.winStreak ?? 0)")
                        Spacer()
                    }
                }
                
                
                VStack {
                    HStack {
                        Text("📉 Current Longest Loss Streak:")
                        Spacer()
                    }
                    HStack {
                        Text("🏆 \(getBiggestLossStreak()?.playerDetails.name ?? "Loading") — \(getBiggestLossStreak()?.lossStreak ?? 0)")
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
            //
            
            
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
    
}

#Preview {
    ShowOtherStats()
}
