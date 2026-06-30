//
//  PokerGroup.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 24/2/2026.
//

import Foundation
import SwiftUI

struct PokerGroup: Identifiable {
    var id: Int
    var name: String
    var color: Color
    var pokerSessions: [PokerSession] = []
    var groupMembers: [GroupMember] = []
    var playerTotals: [PlayerTotals] = []
}


func getTestGroups() -> [PokerGroup] {
    return [
       PokerGroup(id: 1, name: "Test Group", color: Color(red: 240/255, green: 229/255, blue: 132/255)),
       PokerGroup(id: 2, name: "Test Group 2", color: Color(red: 240/255, green: 141/255, blue: 100/255))
   ]
}
