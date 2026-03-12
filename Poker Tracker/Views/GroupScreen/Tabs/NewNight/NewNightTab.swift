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
    
    @State var sessionEntries: [SessionEntry] = []
//    @State var playerNightEntries: [PlayerNightEntry] = [
//        PlayerNightEntry(id: "1", name: "Player 1", startAmount: 20, endAmount: 40, buyIns: 0),
//        PlayerNightEntry(id: "2", name: "Player 2", startAmount: 20, endAmount: 30, buyIns: 0),
//        PlayerNightEntry(id: "3", name: "Player 3", startAmount: 20, endAmount: 20, buyIns: 0),
//        PlayerNightEntry(id: "4", name: "Player 4", startAmount: 20, endAmount: 10, buyIns: 0),
//        PlayerNightEntry(id: "5", name: "Player 5", startAmount: 20, endAmount: 0, buyIns: 0)
//    ]
    
    var sortedSessionEntries: [SessionEntry] {
        sessionEntries.sorted {
            ($0.endAmount - $0.startAmount) >
            ($1.endAmount - $1.startAmount)
        }
    }
    
    func saveNight() {
        // CHECK IF NIGHT VALID
        
    }
    
    var body: some View {
        VStack {
            VStack {
                DatePickerView(selectedDate: $nightDate)
                
                HStack {
                    Text("Players: ")
                        .font(.system(size: 40))
                    Spacer()
                }
                VStack(spacing: 5) {
                    ForEach(sortedSessionEntries) { sessionEntry in
                        PlayerNightRow(sessionEntry: sessionEntry)
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
            Spacer()
            
            SaveNightButton(onTap: saveNight)
            
        }
        .padding(.horizontal, 10)
        .sheet(isPresented: $showingAddPlayer) {
            AddEntryToSessionView { newEntry in
                sessionEntries.append(newEntry)
            }
        }
    }
}

#Preview {
    NewNightTab(onNavigate: {_ in})
}
