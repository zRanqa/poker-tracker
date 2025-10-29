//
//  RootView.swift
//  a1-s4092185-s4008144
//
//  Created by Jonathan Dummett on 24/8/2025.
//

import SwiftUI
import SwiftData

struct RootView: View {
    
    @Binding var currentScreen: AppScreen
    
    var body: some View {
        ZStack {
            switch currentScreen {
            case .homeScreen:
                HomeScreen(
                    onNavigate: { screen in currentScreen = screen }
                )
            case .addNightScreen:
                AddNightScreen(
                    onNavigate: { screen in currentScreen = screen }
                )
            case .addPlayerToNightScreen:
                AddPlayerToNightScreen(
                    onNavigate: { screen in currentScreen = screen }
                )
                
            case .playersScreen:
                PlayersScreen(
                    onNavigate: { screen in currentScreen = screen }
                )
            case .addPlayerDetailsScreen:
                AddPlayerDetailsScreen(
                    onNavigate: { screen in currentScreen = screen }
                )
            }
        }
    }
}

struct PreviewRootWrapper: View {
    @State private var currentScreen: AppScreen = .addNightScreen

    var body: some View {
        RootView(currentScreen: $currentScreen)
    }
}

#Preview {
    PreviewRootWrapper()
}
