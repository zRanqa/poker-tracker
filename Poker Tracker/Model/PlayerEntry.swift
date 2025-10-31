//
//  PlayerEntry.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/10/2025.
//

import Foundation
import SwiftData

@Model
class PlayerEntry: Identifiable {
    var id: UUID = UUID()
    var playerDetails: PlayerDetails 
    var startingAmount: Double
    var endingAmount: Double
    var buyIns: Int
    
    init(id: UUID, playerDetails: PlayerDetails, startingAmount: Double, endingAmount: Double, buyIns: Int) {
        self.id = id
        self.playerDetails = playerDetails
        self.startingAmount = startingAmount
        self.endingAmount = endingAmount
        self.buyIns = buyIns
    }
    
    init(playerDetails: PlayerDetails, startingAmount: Double, endingAmount: Double, buyIns: Int) {
        self.id = UUID()
        self.playerDetails = playerDetails
        self.startingAmount = startingAmount
        self.endingAmount = endingAmount
        self.buyIns = buyIns
    }
    
    var toFirebasePlayerEntry: FirebasePlayerEntry {
        FirebasePlayerEntry(
            id: id,
            playerDetails: playerDetails,
            startingAmount: startingAmount,
            endingAmount: endingAmount,
            buyIns: buyIns
        )
    }
}

func getTestPlayerEntry() -> PlayerEntry {
    return PlayerEntry(
        playerDetails: getTestPlayerDetails(),
        startingAmount: 20,
        endingAmount: Double(Int.random(in: 0...80)) / 2.0,
        buyIns: 1
    )
}

func orderPlayerEntries(playerEntries: [PlayerEntry]) -> [PlayerEntry] {
    return playerEntries.sorted { $0.endingAmount > $1.endingAmount }
}


func calculateMinMax(playerEntries: [PlayerEntry]) -> (Double, Double) {
    if playerEntries.isEmpty {
        return (0,0)
    }
    var minMoney = playerEntries.first!.endingAmount
    var maxMoney = playerEntries.first!.endingAmount
    
    for player in playerEntries {
        if player.endingAmount > maxMoney {
            maxMoney = player.endingAmount
        }
        if player.endingAmount < minMoney {
            minMoney = player.endingAmount
        }
    }
    return (minMoney, maxMoney)
}
