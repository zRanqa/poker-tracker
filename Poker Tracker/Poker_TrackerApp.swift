//
//  Poker_TrackerApp.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/1/2026.
//

import SwiftUI


enum AppScreen {
    
    case loginScreen
    case homeScreen
    case groupScreen(PokerGroup)
}

@main
struct Poker_TrackerApp: App {
    
    @StateObject private var appState = AppState()
        
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
        }
    }
}
