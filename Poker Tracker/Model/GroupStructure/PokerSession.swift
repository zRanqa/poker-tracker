//
//  PokerSession.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 2/3/2026.
//

import Foundation

struct PokerSession {
    var id: String
    var date: Date
    var sessionEntries: [SessionEntry]
}


func getTestPokerSession() -> PokerSession {
    return PokerSession(
        id: UUID().uuidString,
        date: Date(),
        sessionEntries: [
            getTestSessionEntry(),
            getTestSessionEntry(),
            getTestSessionEntry(),
            getTestSessionEntry(),
            getTestSessionEntry()
        ]
    )
}
