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
    
    @State var idNumber: Int = 0 // this is for the new session entrys
    
    var sortedSessionEntries: [SessionEntry] {
        sessionEntries.sorted {
            ($0.endAmount - $0.startAmount) >
            ($1.endAmount - $1.startAmount)
        }
    }
    
    func saveNight() {
        // CHECK IF NIGHT VALID
        idNumber = 0 // reset back to 0 after saving the night
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
                .padding(.bottom, 5)
                VStack(spacing: 5) {
                    ForEach(sortedSessionEntries) { sessionEntry in
                        PlayerNightRow(sessionEntry: sessionEntry)
                    }
                }
                
                Button(action: {
                    showingAddPlayer = true
                    
                }) {
                    Image(systemName: "plus")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.separator), lineWidth: 0.5)
                        )
                }
            }
            Spacer()
            
            SaveNightButton(onTap: saveNight)
            
        }
        .padding(.horizontal, 10)
        .sheet(isPresented: $showingAddPlayer) {
            AddEntryToSessionView(idNumber: $idNumber) { newEntry in
                sessionEntries.append(newEntry)
            }
        }
    }
}

#Preview {
    NewNightTab(onNavigate: {_ in})
}
