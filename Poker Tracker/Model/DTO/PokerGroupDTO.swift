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
