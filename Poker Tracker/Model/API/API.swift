//
//  APIUrl.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 23/6/2026.
//

let API_URL = "http://127.0.0.1:5000/api"

enum APIEndpoints {
    case login
    case refresh
    case getAllGroups
    case getGroupSessions
    case getGroupMembers
    case addNewPokerNight
    case addNewGroupMember
    case addNewGuestMember
    case updateGroupName
    case removeGuestMember
    case turnGuestIntoUser
    case removeUserFromGroup
    case saveGroupRoles
}


func getApiUrl(endpoint: APIEndpoints) -> String {
    switch endpoint {
    case .login:
        return "\(API_URL)/login"
    case .refresh:
        return "\(API_URL)/refresh"
    case .getAllGroups:
        return "\(API_URL)/get-user-groups"
    case .getGroupSessions:
        return "\(API_URL)/get-group-sessions"
    case .getGroupMembers:
        return "\(API_URL)/get-group-members"
    case .addNewPokerNight:
        return "\(API_URL)/add-poker-night"
    case .addNewGroupMember:
        return "\(API_URL)/add-group-member"
    case .addNewGuestMember:
        return "\(API_URL)/add-guest-group-member"
    case .updateGroupName:
        return "\(API_URL)/edit-group-name"
    case .removeGuestMember:
        return "\(API_URL)/remove-guest-group-member"
    case .turnGuestIntoUser:
        return "\(API_URL)/turn-guest-into-user"
    case .removeUserFromGroup:
        return "\(API_URL)/remove-user-from-group"
    case .saveGroupRoles:
        return "\(API_URL)/save-group-roles"
    }
}

