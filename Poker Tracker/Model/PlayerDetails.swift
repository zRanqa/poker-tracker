//
//  PlayerDetails.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/10/2025.
//

import Foundation

struct PlayerDetails: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String // MAX 16 CHARACTERS
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    init(name: String) {
        self.id = UUID()
        self.name = name
    }
}



func getTestPlayerDetails() -> PlayerDetails {
    return PlayerDetails(name: "Test Player")
}
