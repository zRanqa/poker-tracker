//
//  GroupMember.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 12/3/2026.
//

import Foundation

struct GroupMember: Identifiable, Hashable {
    var id: UUID
    var name: String
    var email: String?
    var role: String?
    
    var isGuest: Bool {
        email == nil
    }
}


func getTestGroupMember() -> GroupMember {
    let randomRole: String = ["leader", "moderator", "member"].randomElement()!
    return GroupMember(id: UUID(), name: "Test Member", email: "test@example.com", role: randomRole)
}

func getTestGuestMember() -> GroupMember {
    return GroupMember(id: UUID(), name: "Test Guest", email: nil)
}

func getRandomGroupMember() -> GroupMember {
    let randomBool: Bool = Bool.random()
    return randomBool ? getTestGuestMember() : getTestGroupMember()
}
