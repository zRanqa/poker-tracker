//
//  PlayerEntry.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/10/2025.
//

import Foundation
import SwiftData


struct FirebasePlayerEntry: Identifiable, Codable {
    var id: UUID
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
    
    init(playerEntry: PlayerEntry) {
        self.id = playerEntry.id
        self.playerDetails = playerEntry.playerDetails
        self.startingAmount = playerEntry.startingAmount
        self.endingAmount = playerEntry.endingAmount
        self.buyIns = playerEntry.buyIns
    }
    
    var toPlayerEntry: PlayerEntry {
        PlayerEntry(
            id: self.id,
            playerDetails: self.playerDetails,
            startingAmount: self.startingAmount,
            endingAmount: self.endingAmount,
            buyIns: self.buyIns
        )
    }
}
