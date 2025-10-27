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
}


