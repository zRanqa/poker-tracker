//
//  PokerSession.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 2/3/2026.
//

import Foundation

struct PokerSession {
    var id: Int
    var date: Date
    var sessionEntries: [SessionEntry]
}


func getTestPokerSession(id: Int = 1) -> PokerSession {
    return PokerSession(
        id: id,
        date: Date(),
        sessionEntries: [
            getTestSessionEntry(id: 1),
            getTestSessionEntry(id: 2),
            getTestSessionEntry(id: 3),
            getTestSessionEntry(id: 4),
            getTestSessionEntry(id: 5)
        ]
    )
}
