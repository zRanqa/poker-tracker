//
//  Poker_TrackerApp.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/10/2025.
//

import SwiftUI
import FirebaseCore

enum AppScreen {
    
    case loginScreen
    case groupScreen
    case homeScreen
    case addNightScreen
    case addPlayerToNightScreen
    case allGamesScreen
    case playersScreen
    case addPlayerDetailsScreen
    case playerStatsScreen
    case individualStatsScreen(PlayerTotals)
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct Poker_TrackerApp: App {
    
    @StateObject private var appState = AppState()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
        }
        .modelContainer(for: [PlayerEntry.self, SavedDate.self])
    }
}
