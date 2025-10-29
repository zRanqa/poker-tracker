//
//  NightEntry.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/10/2025.
//

import Foundation

struct FirebaseNightEntry: Identifiable, Codable {
    var id: UUID = UUID()
    var date: Date
    var firebasePlayerEntries: [FirebasePlayerEntry]
    
    init(id: UUID, date: Date, firebasePlayerEntries: [FirebasePlayerEntry]) {
        self.id = id
        self.date = date
        self.firebasePlayerEntries = firebasePlayerEntries
    }
    init(date: Date, firebasePlayerEntries: [FirebasePlayerEntry]) {
        self.id = UUID()
        self.date = date
        self.firebasePlayerEntries = firebasePlayerEntries
    }
    
    var toNightEntry: NightEntry {
        NightEntry(
            id: self.id,
            date: self.date,
            playerEntries: self.firebasePlayerEntries.map(\.toPlayerEntry)
        )
    }
}


