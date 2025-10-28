//
//  AddNightScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/10/2025.
//

import SwiftUI

struct PlayersScreen: View {
    
    var onNavigate: (AppScreen) -> Void
    
    @State var playerDetails: [PlayerDetails] = []
    
    @State var errorMessage: String = ""
    
    
    var body: some View {
        VStack {
            Text("Current Players")
                .font(.title)
                .padding(.bottom)
            
            ScrollView {
                if playerDetails.isEmpty {
                    ForEach(0..<4, id: \.self) { index in
                        PlayerDetailsPlaceholder()
                    }
                }
                
                ForEach (playerDetails, id: \.self.id) { playerDetail in
                    PlayerDetailsView(playerDetails: playerDetail)
                }
                .padding(.top, 5)
                
                AddPlayerView(onTap: {
                    onNavigate(.addPlayerDetailsScreen)
                })
                .padding(.top, 5)
            }
            
            Spacer()
            
            
            
            BottomBar(onNavigate: onNavigate)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            Task {
                do {
                    let players = try await loadAllPlayerDetails()
                    
                    DispatchQueue.main.async {
                        self.playerDetails = players
                    }
                }
            }
        }
    }
}

#Preview {
    PlayersScreen(onNavigate: { _ in })
}
