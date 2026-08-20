//
//  AppState.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 25/12/2025.
//


import Foundation
import JWTDecode


enum AuthError: Error {
    case noRefreshToken
    case invalidRefreshResponse
}


@MainActor
class AppState: ObservableObject {
    @Published var currentScreen: AppScreen = .loginScreen
    @Published var accessToken: String? = nil
    @Published var refreshToken: String? = nil
    @Published var groupId: Int? = nil
    @Published var userId: UUID? = nil
    @Published var currUser: User? = nil
    
    // Tracks the refresh request to stop sending multiple requests
    private var refreshTask: Task<String, Error>? = nil

    var isLoggedIn: Bool {
        self.accessToken != nil
    }
    
    func getUserRoleInGroup(groupMembers: [GroupMember]) -> GroupRole? {
        guard let jwt = try? decode(jwt: refreshToken ?? ""),
              let sub = jwt.body["sub"] as? String else {
            return nil
        }
        if jwt.body.isEmpty {
            return nil
        }
        return groupMembers.first(where: { $0.id.uuidString == sub })?.role
    }
    
    func initLogin() async {
        if let refreshToken = try? KeychainManager.read(forKey: TokenKey.refreshToken) {
            
            do {
                self.refreshToken = refreshToken
                self.accessToken = try await refreshAccessToken()
                self.currentScreen = .homeScreen
            } catch {
                print(error)
                self.currentScreen = .loginScreen
            }
        } else {
            // show login screen
            self.currentScreen = .loginScreen
        }
    }

    func login(user: User, token: String, refreshToken: String) {
        self.currUser = user
        self.accessToken = token
        self.refreshToken = refreshToken
        
        try? KeychainManager.save(token, forKey: TokenKey.accessToken)
        try? KeychainManager.save(refreshToken, forKey: TokenKey.refreshToken)
        
        self.currentScreen = .homeScreen
    }
    

    func logout() {
        self.accessToken = nil
        self.refreshToken = nil
        self.refreshTask = nil
        self.userId = nil
        self.currUser = nil
        
        try? KeychainManager.delete(forKey: TokenKey.accessToken)
        try? KeychainManager.delete(forKey: TokenKey.refreshToken)
        
        self.currentScreen = .loginScreen
    }
    
    func validAccessToken() async throws -> String {
        if let accessToken, !isExpired(accessToken) {
            return accessToken
        }
        return try await refreshAccessToken()
    }
    
    private func refreshAccessToken() async throws -> String {
        // If a refresh is already running, just wait on that one
        // instead of starting a second network call.
        if let existingTask = refreshTask {
            return try await existingTask.value
        }

        let task = Task<String, Error> {
            guard let refreshToken else {
                logout()
                throw AuthError.noRefreshToken
            }

            do {
                let refreshResponse = try await AuthAPI.refresh(refreshToken: refreshToken)
                guard let token = refreshResponse?.token, let user = refreshResponse?.user else {
                    throw AuthError.invalidRefreshResponse
                }
                self.accessToken = token
                self.currUser = user
                try? KeychainManager.save(refreshResponse!.token!, forKey: TokenKey.accessToken)
                return self.accessToken!
            } catch {
                logout()
                throw error
            }
        }

        refreshTask = task

        defer { refreshTask = nil }
        return try await task.value
    }

    private func isExpired(_ token: String) -> Bool {
        guard let jwt = try? decode(jwt: token) else {
            return true // malformed/unparseable
        }
        return jwt.expired // handles exp claim comparison for you
    }
}
