//
//  PokerGroupDTO.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 23/6/2026.
//

struct PokerGroupDTO: Codable {
    let id: Int
    let name: String
    let created_at: String
    let color_hex: String
}

struct PokerGroupsResponse: Codable {
    let status: String
    let message: String
    let data: [PokerGroupDTO]
}


struct UpdateGroupNameRequest: Codable {
    let group_id: Int
    let name: String
}


struct RemoveGuestMemberRequest: Codable {
    let group_id: Int
    let id: String
}


struct TurnGuestIntoUserRequest: Codable {
    let group_id: Int
    let guest_id: String
    let user_email: String
}


struct RemoveUserFromGroupRequest: Codable {
    let group_id: Int
    let user_id: String
}


struct SaveGroupRolesRequest: Codable {
    let group_id: Int
    let group_members: [GroupMemberRoleDTO]
}

struct GroupMemberRoleDTO: Codable {
    let id: String
    let role: String
}
