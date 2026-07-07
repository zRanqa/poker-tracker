//
//  AppState.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 25/12/2025.
//

import Foundation

class AppState: ObservableObject {
    @Published var currentScreen: AppScreen = .loginScreen
    @Published var token: String? = nil
    @Published var groupId: Int? = nil

    var isLoggedIn: Bool {
        token != nil
    }

    func login(with token: String) {
        self.token = token
        self.currentScreen = .homeScreen
    }

    func logout() {
        self.token = nil
        self.currentScreen = .loginScreen
    }
}
