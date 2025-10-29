//
//  Poker_TrackerApp.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/10/2025.
//

import SwiftUI
import FirebaseCore

enum AppScreen {
    case homeScreen
    case addNightScreen
    case addPlayerToNightScreen
    case playersScreen
    case addPlayerDetailsScreen
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
    
    @State private var currentScreen: AppScreen = .homeScreen
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
    var body: some Scene {
        WindowGroup {
            RootView(currentScreen: $currentScreen)
        }
        .modelContainer(for: [PlayerEntry.self, SavedDate.self])
    }
}
