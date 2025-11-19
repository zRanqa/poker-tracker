//
//  AllGamesScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 29/10/2025.
//

import SwiftUI

struct AllGamesScreen: View {
    
    var onNavigate: (AppScreen) -> Void
    
    @State var nightEntries: [NightEntry] = []
    
    var body: some View {
        VStack {
            Text("All Games")
                .font(.title)
                .padding(.bottom)
            
            ScrollView {
                VStack {
                    
//                    ViewPlayersButton(text: "View Players", onTap: { onNavigate(.playersScreen) })
                    
                    ForEach (orderNightEntries(), id: \.self.id) { nightEntry in
                        NightEntryView(nightEntry: nightEntry)
                    }
                }
            }
            
            Spacer()
            
            
            BottomBar(onNavigate: onNavigate)
                .padding(.horizontal, -10)
            
        }
        .padding(.horizontal, 10)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear() {
            Task {
                nightEntries = try await loadAllNightEntries()
            }
        }
    }
    
    func orderNightEntries() -> [NightEntry] {
        return nightEntries.sorted { $0.date > $1.date }
    }
        
}

#Preview {
    AllGamesScreen(onNavigate: { _ in })
}
