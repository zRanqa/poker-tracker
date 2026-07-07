//
//  GroupMemberDTO.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 30/6/2026.
//

import Foundation

struct GroupMemberDTO: Codable {
    let id: String
    let name: String
    let email: String?
    let role: String?
}

struct GroupMemberResponse: Codable {
    let status: String
    let message: String
    let data: [GroupMemberDTO]
}


struct AddGroupMemberResponse: Codable {
    let status: String
    let message: String
}

struct AddGroupMemberRequest: Encodable {
    let group_id: Int
    let email: String
}

struct AddGuestMemberRequest: Encodable {
    let group_id: Int
    let name: String
    let id: UUID
}

