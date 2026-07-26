//
//  GroupMember.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 12/3/2026.
//

import Foundation

enum GroupRole: String, Codable {
    case leader
    case moderator
    case member
}

struct GroupMember: Identifiable, Hashable {
    var id: UUID
    var name: String
    var email: String?
    var role: GroupRole?
    
    var isGuest: Bool {
        email == nil
    }
}


func getTestGroupMember() -> GroupMember {
    let randomRole: GroupRole = [.leader, .member, .moderator].randomElement()!
    return GroupMember(id: UUID(), name: "Test Member", email: "test@example.com", role: randomRole)
}

func getTestGuestMember() -> GroupMember {
    return GroupMember(id: UUID(), name: "Test Guest", email: nil)
}

func getRandomGroupMember() -> GroupMember {
    let randomBool: Bool = Bool.random()
    return randomBool ? getTestGuestMember() : getTestGroupMember()
}
