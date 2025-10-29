//
//  AllGamesScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 29/10/2025.
//

import SwiftUI

struct AllGamesScreen: View {
    
    var onNavigate: (AppScreen) -> Void
    
    var body: some View {
        VStack {
            Text("All Games")
                .font(.title)
                .padding(.bottom)
            
            ViewPlayersButton(text: "View Players", onTap: { onNavigate(.playersScreen) })
            
            Spacer()
            
            
            BottomBar(onNavigate: onNavigate)
                .padding(.horizontal, -10)
            
        }
        .padding(.horizontal, 10)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    AllGamesScreen(onNavigate: { _ in })
}
