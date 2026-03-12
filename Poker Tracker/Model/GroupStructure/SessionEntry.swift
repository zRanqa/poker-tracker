//
//  PlayerNightEntry.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 2/3/2026.
//

import Foundation

struct SessionEntry: Identifiable {
    var id: String
    var groupMember: GroupMember
    
    var startAmount: Double
    var endAmount: Double
    var buyIns: Int
}

func getTestSessionEntry() -> SessionEntry {
    return SessionEntry(id: UUID().uuidString, groupMember: getRandomGroupMember(), startAmount: 20.0, endAmount: Double(Int.random(in: 0...60)) / 2.0 + 10, buyIns: Int.random(in: 0...2))
}
