//
//  APIUrl.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 23/6/2026.
//

let API_URL = "http://127.0.0.1:5000/api"

enum APIEndpoints {
    case login
    case getAllGroups
    case getGroupSessions
    case getGroupMembers
    case addNewPokerNight
    case addNewGroupMember
    case addNewGuestMember
    case updateGroupName
}


func getApiUrl(endpoint: APIEndpoints) -> String {
    switch endpoint {
    case .login:
        return "\(API_URL)/login"
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
    }
}
