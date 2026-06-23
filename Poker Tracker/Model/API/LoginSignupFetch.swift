//
//  Fetch.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 23/6/2026.
//

import Foundation

func loginFromApi(email: String, password: String) async throws -> LoginDTO? {
    
    guard let url = URL(string: getApiUrl(endpoint: .login)) else {
        return nil
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try JSONEncoder().encode([
        "email": email,
        "password": password
    ])
    
    let (data, _) = try await URLSession.shared.data(for: request)
    
    let loginDTO = try JSONDecoder().decode(LoginDTO.self, from: data)

    return loginDTO
}
