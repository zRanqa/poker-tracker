//
//  AuthApi.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 8/7/2026.
//
import Foundation

enum AuthAPI {
    static func refresh(refreshToken: String) async throws -> String {
        guard let url = URL(string: getApiUrl(endpoint: .refresh)) else {
            return ""
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let refreshDTO = try JSONDecoder().decode(RefreshResponse.self, from: data)

        return refreshDTO.data
    }
}
