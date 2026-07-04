//
//  GroupScreenFetch.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 28/6/2026.
//


import Foundation

func fetchGroupSessions(token: String, groupId: Int, groupMembers: [GroupMember]) async throws -> [PokerSession] {
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
                groupMember: groupMembers.first(where: { $0.id == UUID(uuidString: dto.user_id) })!,
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

func fetchGroupMembers(token: String, groupId: Int) async throws -> [GroupMember] {
    guard let url = URL(string: getApiUrl(endpoint: .getGroupMembers)) else {
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
    let groupMemberDTO = try JSONDecoder().decode(GroupMemberResponse.self, from: data)
    
    let groupMembers: [GroupMember] = groupMemberDTO.data.map { dto in
        GroupMember(
            id: UUID(uuidString: dto.id) ?? UUID(),
            name: dto.name,
            email: dto.email,
            role: dto.role
        )
    }
    
    return groupMembers
}


func createPokerSession(token: String, groupId: Int, pokerSession: PokerSession) async throws -> CreatePokerSessionResponse {
    guard let url = URL(string: getApiUrl(endpoint: .addNewPokerNight)) else {
        return CreatePokerSessionResponse(status: "error", message: "Error getting URL")
    }
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    request.httpBody = try JSONEncoder().encode(CreatePokerSessionRequest(
        group_id: groupId,
        date: formatter.string(from: pokerSession.date),
        night_entries: pokerSession.sessionEntries.map { NightEntryRequest(
            id: $0.groupMember.id.uuidString,
            starting_amount: $0.startAmount,
            ending_amount: $0.endAmount,
            buy_ins: $0.buyIns
        )}
    ))
    
    let (data, _) = try await URLSession.shared.data(for: request)
    let createPokerSessionResponse = try JSONDecoder().decode(CreatePokerSessionResponse.self, from: data)
    
    return createPokerSessionResponse
    
}
