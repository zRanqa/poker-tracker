//
//  GroupScreenFetch.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 28/6/2026.
//


import Foundation

func fetchGroupSessions(token: String, groupId: Int) async throws -> [PokerSession] {
    guard let url = URL(string: getApiUrl(endpoint: .getGroupSessions)) else {
        return []
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    request.httpBody = try JSONEncoder().encode([
        "group_id": groupId
    ])
    
    let (data, _) = try await URLSession.shared.data(for: request)
    let pokerSessionDTO = try JSONDecoder().decode(PokerSessionsResponse.self, from: data)
    
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    var pokerSessions: [PokerSession] = []
    for session in pokerSessionDTO.data {
        let sessionEntries = session.sessions.map { dto in
            SessionEntry(
                id: dto.id,
                groupMemberId: UUID(uuidString: dto.user_id) ?? UUID(),
                startAmount: dto.starting_amount,
                endAmount: dto.ending_amount,
                buyIns: dto.buy_ins
            )
        }
        
        pokerSessions.append(
            PokerSession(
                id: session.id,
                date: formatter.date(from: session.date) ?? Date(),
                sessionEntries: sessionEntries
            )
        )
    }

    return pokerSessions
}
