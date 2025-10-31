//
//  PlayerTotals.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 31/10/2025.
//

import Foundation

struct PlayerTotals: Identifiable {
    var id = UUID()
    var playerDetails: PlayerDetails
    var buyIns: Int = 0
    
    var totalMoney: Double
    var totalGames: Int = 0
    
    var winStreak: Int = 0
    var stopWinStreak: Bool = true
    
    var lossStreak: Int = 0
    var stopLossStreak: Bool = true
    
    var mostMoneyWon: Double = 0
}

func calculateTotals() async -> [PlayerTotals] {
    var playerTotals: [PlayerTotals] = []
    do {
        let nightEntries = try await loadAllNightEntries().sorted(by: { $0.date > $1.date })
        let allPlayerDetails = try await loadAllPlayerDetails()
        
        // Initialise the player totals list
        for player in allPlayerDetails {
            playerTotals.append(PlayerTotals(playerDetails: player, totalMoney: 0))
        }
        
        for night in nightEntries {
            for playerEntry in night.playerEntries {
                if let index = playerTotals.firstIndex(where: { $0.playerDetails.id == playerEntry.playerDetails.id }) {
                    // Total money
                    playerTotals[index].totalMoney += playerEntry.endingAmount - playerEntry.startingAmount
                    
                    // Total games
                    playerTotals[index].totalGames += 1
                    
                    // Win Streak
                    if playerTotals[index].stopWinStreak && (playerEntry.endingAmount > playerEntry.startingAmount) {
                        playerTotals[index].winStreak += 1
                    }
                    else {
                        playerTotals[index].stopWinStreak = false
                    }
                    
                    // Loss Streak
                    if playerTotals[index].stopLossStreak && (playerEntry.endingAmount < playerEntry.startingAmount) {
                        playerTotals[index].lossStreak += 1
                    }
                    else {
                        playerTotals[index].stopLossStreak = false
                    }
                    
                    // Buy Ins
                    playerTotals[index].buyIns += playerEntry.buyIns
                    
                    // Most Money
                    if playerEntry.endingAmount - playerEntry.startingAmount > playerTotals[index].mostMoneyWon {
                        playerTotals[index].mostMoneyWon = playerEntry.endingAmount - playerEntry.startingAmount
                    }
                }
            }
        }
        
        return playerTotals
    }
    catch {
        print("Error while calculating totals: \(error)")
        return []
    }
}
