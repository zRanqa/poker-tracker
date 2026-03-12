//
//  GroupMember.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 12/3/2026.
//

import Foundation

struct GroupMember: Identifiable {
    var id: String
    var name: String
    var email: String?
    
    var isGuest: Bool {
        email == nil
    }
}


func getTestGroupMember() -> GroupMember {
    return GroupMember(id: UUID().uuidString, name: "Test Member", email: "test@example.com")
}

func getTestGuestMember() -> GroupMember {
    return GroupMember(id: UUID().uuidString, name: "Test Guest", email: nil)
}

func getRandomGroupMember() -> GroupMember {
    let randomBool: Bool = Bool.random()
    return randomBool ? getTestGuestMember() : getTestGroupMember()
}
