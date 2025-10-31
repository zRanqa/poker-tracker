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
    var totalMoney: Double
    var totalGames: Int = 0
}

func calculateTotals() async -> [PlayerTotals] {
    var playerTotals: [PlayerTotals] = []
    do {
        let nightEntries = try await loadAllNightEntries()
        let allPlayerDetails = try await loadAllPlayerDetails()
        
        // Initialise the player totals list
        for player in allPlayerDetails {
            playerTotals.append(PlayerTotals(playerDetails: player, totalMoney: 0))
        }
        
        for night in nightEntries {
            for playerEntry in night.playerEntries {
                if let index = playerTotals.firstIndex(where: { $0.playerDetails.id == playerEntry.playerDetails.id }) {
                    playerTotals[index].totalMoney += playerEntry.endingAmount - playerEntry.startingAmount
                    playerTotals[index].totalGames += 1
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
