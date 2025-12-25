//
//  RootView.swift
//  a1-s4092185-s4008144
//
//  Created by Jonathan Dummett on 24/8/2025.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @Environment(\.modelContext) private var context
    @Query var playerEntries: [PlayerEntry] = []
    @Query var savedDates: [SavedDate] = []
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            switch appState.currentScreen {
            case .loginScreen:
                LoginScreen(
                    onNavigate: { screen in appState.currentScreen = screen }
                )
            case .groupScreen:
                GroupScreen(
                    onNavigate: { screen in appState.currentScreen = screen }
                )
            case .homeScreen:
                HomeScreen(
                    onNavigate: { screen in appState.currentScreen = screen }
                )
            case .addNightScreen:
                AddNightScreen(
                    onNavigate: { screen in appState.currentScreen = screen }
                )
            case .addPlayerToNightScreen:
                AddPlayerToNightScreen(
                    onNavigate: { screen in appState.currentScreen = screen }
                )
            case .allGamesScreen:
                AllGamesScreen(
                    onNavigate: { screen in appState.currentScreen = screen }
                )
            case .playersScreen:
                PlayersScreen(
                    onNavigate: { screen in appState.currentScreen = screen }
                )
            case .addPlayerDetailsScreen:
                AddPlayerDetailsScreen(
                    onNavigate: { screen in appState.currentScreen = screen }
                )
            case .playerStatsScreen:
                PlayerStatsScreen(
                    onNavigate: { screen in appState.currentScreen = screen }
                )
            case .individualStatsScreen(let playerTotals):
                IndividualStatsScreen(
                    playerTotals: playerTotals,
                    onNavigate: { screen in appState.currentScreen = screen}
                )
            }
        }
        .onAppear() {
            for player in playerEntries {
                context.delete(player)
            }
            for date in savedDates {
                context.delete(date)
            }
        }
    }
}

struct PreviewRootWrapper: View {
    @State private var currentScreen: AppScreen = .addNightScreen

    var body: some View {
        RootView()
    }
}

#Preview {
    PreviewRootWrapper()
}
