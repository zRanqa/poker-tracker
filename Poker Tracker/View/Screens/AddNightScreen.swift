//
//  AddNightScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/10/2025.
//

import SwiftUI

struct AddNightScreen: View {
    
    var onNavigate: (AppScreen) -> Void
    @State var inputDate: Date = Date()
    
    @State var playerEntries: [PlayerEntry] = []
    
    var body: some View {
        VStack {
            Text("Add Night")
                .font(.title)
                .padding(.bottom)
            
            ScrollView {
                VStack {
                    DatePickerView(selectedDate: $inputDate)
                        .padding(.bottom, 20)
                        .padding(.top, 5)
                    
                    HStack {
                        Text("Players")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    VStack {
                        ForEach (playerEntries, id: \.self.id) { playerEntry in
                            PlayerEntryView(playerEntry: playerEntry)
                        }
                        // For each
                        //      Player view
                        
                        AddPlayerView(onTap: addPlayer)
                        
                        AddPlayerView(onTap: addPlayerTestFunction)
                        // Add player button
                    }
                    
                    // add button
                }
                
                Spacer()
            }
            .padding(.horizontal, 10)
            
            BottomBar(onNavigate: onNavigate)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func addPlayer() {
//        playerEntries.append(getTestPlayerEntry())
        onNavigate(.addPlayerToNightScreen)
        print("Add Player")
    }
    
    
    func addPlayerTestFunction() {
        playerEntries.append(getTestPlayerEntry())
    }
}

#Preview {
    AddNightScreen(onNavigate: { _ in })
}
