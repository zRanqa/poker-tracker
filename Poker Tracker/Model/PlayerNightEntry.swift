//
//  PlayerNightEntry.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 2/3/2026.
//

import Foundation

struct PlayerNightEntry: Identifiable {
    var id: String
    var name: String // REPLACE WITH LIKE PLAYER DETAILS
    
    var startAmount: Double
    var endAmount: Double
    var buyIns: Int
}

func getTestPlayerNightEntry() -> PlayerNightEntry {
    return PlayerNightEntry(id: UUID().uuidString, name: "Player", startAmount: 20.0, endAmount: Double(Int.random(in: 0...60)) / 2.0 + 10, buyIns: Int.random(in: 0...2))
}
