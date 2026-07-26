//
//  AuthDTO.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 16/7/2026.
//

struct RefreshTokens: Codable {
    let refresh_token: String
    let access_token: String
}

struct RefreshResponse: Codable {
    let status: String
    let message: String
    let data: String
}
