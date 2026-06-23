//
//  LoginResponse.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 23/6/2026.
//

struct LoginDTO: Codable {
    let status: String
    let message: String
    let data: String?
}
