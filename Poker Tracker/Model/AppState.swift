//
//  AppState.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 25/12/2025.
//

import Foundation

class AppState: ObservableObject {
    @Published var currentScreen: AppScreen = .homeScreen
    @Published var token: String? = nil

    var isLoggedIn: Bool {
        token != nil
    }

    func login(with token: String) {
        self.token = token
//        self.currentScreen = .groupScreen
    }

    func logout() {
        self.token = nil
        self.currentScreen = .loginScreen
    }
}
