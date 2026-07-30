//
//  HomeScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 23/6/2026.
//

import Foundation
import SwiftUI

enum HomeScreenAPI {
    static func fetchGroups(token: String) async throws -> [PokerGroup] {
        guard let url = URL(string: getApiUrl(endpoint: .getAllGroups)) else {
            return []
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let pokerGroupDTO = try JSONDecoder().decode(PokerGroupsResponse.self, from: data)
        
        let pokerGroups = pokerGroupDTO.data.map{ dto in
            PokerGroup(
                id: dto.id,
                name: dto.name,
                color: Color(hex: dto.color_hex)
            )
        }
        
        return pokerGroups
    }
    
    static func createGroup(token: String, name: String, color: Color) async throws -> GenericResponse {
        guard let url = URL(string: getApiUrl(endpoint: .createGroup)) else {
            return GenericResponse(status: "error", message: "Error getting URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try JSONEncoder().encode([
            "name": name,
            "color_hex": color.toHex() ?? "#F0E584"
        ])
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(GenericResponse.self, from: data)
        
        return response
    }
    
}
