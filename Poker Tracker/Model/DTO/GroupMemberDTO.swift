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
