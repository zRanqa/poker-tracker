//
//  PlayerNightEntry.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 2/3/2026.
//

import Foundation

struct SessionEntry: Identifiable {
    var id: Int
    var groupMemberId: UUID
    
    var startAmount: Double
    var endAmount: Double
    var buyIns: Int
}

func getTestSessionEntry(id: Int = 1) -> SessionEntry {
    return SessionEntry(id: id, groupMemberId: UUID(), startAmount: 20.0, endAmount: Double(Int.random(in: 0...60)) / 2.0 + 10, buyIns: Int.random(in: 0...2))
}
