//
//  PokerSession.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 2/3/2026.
//

import Foundation

struct PokerSession {
    var id: String
    var name: String
    var date: Date
    var playerNightEntries: [PlayerNightEntry]
}


func getTestPokerSession() -> PokerSession {
    return PokerSession(
        id: UUID().uuidString,
        name: "Test Session",
        date: Date(),
        playerNightEntries: [
            getTestPlayerNightEntry(),
            getTestPlayerNightEntry(),
            getTestPlayerNightEntry(),
            getTestPlayerNightEntry(),
            getTestPlayerNightEntry()
        ]
    )
}
