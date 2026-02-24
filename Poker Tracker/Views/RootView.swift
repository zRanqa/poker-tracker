//
//  RootView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/1/2026.
//

import SwiftUI

struct RootView: View {

    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            switch appState.currentScreen {
            case .loginScreen:
                LoginScreen(
                    onNavigate: { screen in appState.currentScreen = screen }
                )
            case .homeScreen:
                HomeScreen(
                    onNavigate: { screen in appState.currentScreen = screen }
                )
            case .groupScreen:
                Text("yes")
                
                //                HomeScreen(
                //                    onNavigate: { screen in appState.currentScreen = screen }
                //                )
            }
            //        .onAppear() {
            //            for player in playerEntries {
            //                context.delete(player)
            //            }
            //            for date in savedDates {
            //                context.delete(date)
            //            }
            //       }
        }
    }
}

struct PreviewRootWrapper: View {
    
    @StateObject private var appState = AppState()

    var body: some View {
        RootView()
            .environmentObject(appState)
    }
}

#Preview {
    PreviewRootWrapper()
}

