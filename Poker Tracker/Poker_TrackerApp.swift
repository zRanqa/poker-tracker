//
//  Poker_TrackerApp.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/10/2025.
//

import SwiftUI

enum AppScreen {
    case addNightScreen
    case addPlayerToNightScreen
}

@main
struct Poker_TrackerApp: App {
    
    @State private var currentScreen: AppScreen = .addNightScreen
    
    var body: some Scene {
        WindowGroup {
            RootView(currentScreen: $currentScreen)
        }
    }
}
