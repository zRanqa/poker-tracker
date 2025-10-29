//
//  NightEntry.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/10/2025.
//

import Foundation

struct NightEntry: Identifiable {
    var id: UUID = UUID()
    var date: Date
    var playerEntries: [PlayerEntry]
    
    init(id: UUID, date: Date, playerEntries: [PlayerEntry]) {
        self.id = id
        self.date = date
        self.playerEntries = playerEntries
    }
    init(date: Date, playerEntries: [PlayerEntry]) {
        self.id = UUID()
        self.date = date
        self.playerEntries = playerEntries
    }
    
    var toFirebaseNightEntry: FirebaseNightEntry {
        FirebaseNightEntry(
            id: id,
            date: date,
            firebasePlayerEntries: playerEntries.map(\.toFirebasePlayerEntry))
    }
}


