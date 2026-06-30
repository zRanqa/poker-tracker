//
//  HomeScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 23/6/2026.
//

import Foundation
import SwiftUI

func fetchGroups(token: String) async throws -> [PokerGroup] {
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
