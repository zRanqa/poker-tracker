//
//  Fetch.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 23/6/2026.
//

import Foundation

enum LoginSignupAPI {
    static func loginFromApi(email: String, password: String) async throws -> LoginDTO? {
        
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
    
    static func createVerificationCode(email: String) async throws -> GenericResponse? {
        guard let url = URL(string: getApiUrl(endpoint: .createVerificationCode)) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode([
            "email": email
        ])
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let response = try JSONDecoder().decode(GenericResponse.self, from: data)
        
        return response
    }
    
    static func signupNewAccount(email: String, password: String, name: String, code: String) async throws -> GenericResponse? {
        guard let url = URL(string: getApiUrl(endpoint: .createAccount)) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode([
            "email": email,
            "password": password,
            "name": name,
            "code": code,
            "uuid": UUID().uuidString
        ])
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let response = try JSONDecoder().decode(GenericResponse.self, from: data)
        
        return response
    }
}

