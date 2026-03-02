//
//  NewNightTab.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 26/2/2026.
//

import SwiftUI

struct NewNightTab: View {
    
    
    var onNavigate: (AppScreen) -> Void
    
    @State var nightDate: Date = Date()
    
    @State var showingAddPlayer = false
    @State var playerNightEntries: [PlayerNightEntry] = []
    
    var sortedPlayerNightEntries: [PlayerNightEntry] {
        playerNightEntries.sorted {
            ($0.endAmount - $0.startAmount) >
            ($1.endAmount - $1.startAmount)
        }
    }
    
    var body: some View {
        VStack {
            DatePickerView(selectedDate: $nightDate)
            
            HStack {
                Text("Players: ")
                    .font(.system(size: 40))
                Spacer()
            }
            VStack(spacing: 5) {
                ForEach(sortedPlayerNightEntries) { playerEntry in
                    PlayerNightRow(playerNightEntry: playerEntry)
                }
            }
        
            Button(action: {
                showingAddPlayer = true
                
            }) {
                Image(systemName: "plus")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .border(Color.blue, width: 1)
            }
            
        }
        .padding(.horizontal, 10)
        .sheet(isPresented: $showingAddPlayer) {
            AddPlayerToNightView { newEntry in
                playerNightEntries.append(newEntry)
            }
        }
    }
}

#Preview {
    NewNightTab(onNavigate: {_ in})
}
