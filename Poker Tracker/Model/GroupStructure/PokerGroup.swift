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

func getTestGroup() -> PokerGroup {
    let groupMembers: [GroupMember] = [
        GroupMember(id: UUID(), name: "Member 1", email: "member1@email.com", role: "leader"),
        GroupMember(id: UUID(), name: "Member 2", email: "member2@email.com", role: "moderator"),
        GroupMember(id: UUID(), name: "Member 3", email: "member3@email.com", role: "moderator"),
        GroupMember(id: UUID(), name: "Member 4", email: "member4@email.com", role: "member"),
        GroupMember(id: UUID(), name: "Member 5", email: "member5@email.com", role: "member"),
        GroupMember(id: UUID(), name: "Member 6", email: "member6@email.com", role: "member"),
        GroupMember(id: UUID(), name: "Guest 1", email: nil, role: nil),
        GroupMember(id: UUID(), name: "Guest 2", email: nil, role: nil)
    ]
    let pokerSessions: [PokerSession] = [
        PokerSession(id: 1, date: Date(), sessionEntries: [
            SessionEntry(id: "1", groupMember: groupMembers[0], startAmount: 100, endAmount: 250, buyIns: 1),
            SessionEntry(id: "2", groupMember: groupMembers[1], startAmount: 100, endAmount: 40, buyIns: 2),
            SessionEntry(id: "3", groupMember: groupMembers[3], startAmount: 100, endAmount: 180, buyIns: 1),
            SessionEntry(id: "4", groupMember: groupMembers[6], startAmount: 50, endAmount: 0, buyIns: 1)
        ]),
        PokerSession(id: 2, date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, sessionEntries: [
            SessionEntry(id: "5", groupMember: groupMembers[0], startAmount: 100, endAmount: 60, buyIns: 1),
            SessionEntry(id: "6", groupMember: groupMembers[2], startAmount: 100, endAmount: 320, buyIns: 2),
            SessionEntry(id: "7", groupMember: groupMembers[4], startAmount: 100, endAmount: 100, buyIns: 1),
            SessionEntry(id: "8", groupMember: groupMembers[5], startAmount: 100, endAmount: 75, buyIns: 1)
        ]),
        PokerSession(id: 3, date: Calendar.current.date(byAdding: .day, value: -14, to: Date())!, sessionEntries: [
            SessionEntry(id: "9", groupMember: groupMembers[1], startAmount: 100, endAmount: 210, buyIns: 1),
            SessionEntry(id: "10", groupMember: groupMembers[3], startAmount: 100, endAmount: 90, buyIns: 1),
            SessionEntry(id: "11", groupMember: groupMembers[5], startAmount: 100, endAmount: 45, buyIns: 2),
            SessionEntry(id: "12", groupMember: groupMembers[7], startAmount: 50, endAmount: 20, buyIns: 1)
        ])
    ]
    return PokerGroup(id: -1, name: "Test Group", color: Color(red: 240/255, green: 229/255, blue: 132/255), pokerSessions: pokerSessions, groupMembers: groupMembers)
}
