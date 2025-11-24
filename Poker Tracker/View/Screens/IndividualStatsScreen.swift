//
//  IndividualStatsScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 20/11/2025.
//

import SwiftUI

struct IndividualStatsScreen: View {
    
    var playerTotals: PlayerTotals
    
    var onNavigate: (AppScreen) -> Void
    
    var body: some View {
        VStack {
            VStack {
                Text("\(playerTotals.playerDetails.name)'s Stats")
                    .font(.title)
                    .padding(.bottom, 10)
//                ScrollView {
//                    VStack {
                        
                LineGraph(dollarAmounts: playerTotals.linePoints)
                
                
                VStack {
                    HStack {
                        Text("Games Played: \(playerTotals.totalGames)")
                        Spacer()
                    }
                    HStack {
                        Text("Total Wins: \(playerTotals.totalWins)")
                        Spacer()
                    }
                    HStack {
                        Text("Total Lossess: \(playerTotals.totalLosses)")
                        Spacer()
                    }
                    HStack {
                        Text("Total Buy Ins: \(playerTotals.buyIns)")
                        Spacer()
                    }
                    
                    Text("")
                    
                    HStack {
                        Text("Win Percentage: \(formatPercentage(amount: playerTotals.winPercentage))")
                        Spacer()
                    }
                    HStack {
                        Text("Loss Percentage: \(formatPercentage(amount: playerTotals.lossPercentage))")
                        Spacer()
                    }
                    
                    Text("")
                    
                    HStack {
                        Text("Current Winstreak: \(playerTotals.winStreak)")
                        Spacer()
                    }
                    HStack {
                        Text("Current Loss Streak: \(playerTotals.lossStreak)")
                        Spacer()
                    }
                    
                    Text("")
                    
                    HStack {
                        Text("Most Money Won In A Night: \(formatAmount(amount: playerTotals.mostMoneyWon))")
                        Spacer()
                    }
                    HStack {
                        Text("Most Money Lost In A Night: \(formatAmount(amount: playerTotals.mostMoneyLost))")
                        Spacer()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                .padding(.horizontal)
//                    }
//                    .padding(.vertical, 5)
//                }
            }
            Spacer()
            
            BottomBar(onNavigate: onNavigate)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    IndividualStatsScreen(playerTotals: PlayerTotals(playerDetails: getTestPlayerDetails(), totalMoney: 0), onNavigate: { _ in})
}
