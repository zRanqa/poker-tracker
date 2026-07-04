//
//  PlayerNightEntry.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 2/3/2026.
//

import Foundation

struct SessionEntry: Identifiable, Equatable {
    var id: String
    var groupMember: GroupMember
    
    var startAmount: Double
    var endAmount: Double
    var buyIns: Int
    
    func toDict() -> [String: Any] {
        return [
            "id": groupMember.id.uuidString,
            "starting_amount": startAmount,
            "ending_amount": endAmount,
            "buy_ins": buyIns
        ]
    }
}

func getTestSessionEntry(id: Int = 1) -> SessionEntry {
    return SessionEntry(id: String(id), groupMember: getRandomGroupMember(), startAmount: 20.0, endAmount: Double(Int.random(in: 0...60)) / 2.0 + 10, buyIns: Int.random(in: 0...2))
}
