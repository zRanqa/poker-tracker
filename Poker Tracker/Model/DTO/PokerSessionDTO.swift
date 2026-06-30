//
//  PokerSessionDTO.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 28/6/2026.
//

struct PokerSessionDTO: Codable {
    let id: Int
    let date: String
    let created_by: String
    let sessions: [SessionEntryDTO]
}

struct SessionEntryDTO: Codable {
    let id: String
    let user_id: String
    let starting_amount: Double
    let ending_amount: Double
    let buy_ins: Int
}

struct PokerSessionsResponse: Codable {
    let status: String
    let message: String
    let data: [PokerSessionDTO]
}
