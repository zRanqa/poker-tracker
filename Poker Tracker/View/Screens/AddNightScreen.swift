//
//  AddNightScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/10/2025.
//

import SwiftUI
import SwiftData

struct AddNightScreen: View {
    @Environment(\.modelContext) private var context
    @Query var playerEntries: [PlayerEntry] = []
    @Query var savedDates: [SavedDate] = []
    
    var onNavigate: (AppScreen) -> Void
    var newPlayerEntry: PlayerEntry?
    
    @State var inputDate: Date = Date()
    @State var errorMessage: String = ""
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("Add Night")
                    .font(.title)
                    .padding(.bottom)
                
                VStack {
                    DatePickerView(selectedDate: $inputDate, onUpdate: saveChosenDate)
                        .padding(.bottom, 20)
                }
                .padding(.horizontal, 10)
                
                VStack {
                    HStack {
                        Text("Players:")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    ScrollView {
                        VStack {
                            
                            VStack {
                                ForEach (orderPlayerEntries(), id: \.self.id) { playerEntry in
                                    PlayerEntryView(playerEntry: playerEntry)
                                }
                                
                                AddPlayerView(onTap: addPlayer)
                                
                            }
                            .padding(.top, 5)
                            
                            
                        }
                    }
                }
                .padding(.horizontal, 10)
                
                Spacer()
                
                VStack {
                    
                    if !errorMessage.isEmpty {
                        ErrorMessage(message: errorMessage)
                    }
                    
                    WideButton(name: "Add Night", color: .green, onTap: addNight)
                    
//                    WideButton(name: "Cancel", color: .red, onTap: {})
                }
                .padding(.horizontal, 10)
                
                BottomBar(onNavigate: onNavigate)
            }
            .onAppear() {
                if !savedDates.isEmpty {
                    inputDate = savedDates.first!.date
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func addNight() {
        var totalMoneyInPot = 0.0
        
        for player in playerEntries {
            totalMoneyInPot += player.endingAmount - player.startingAmount
        }
        
        if totalMoneyInPot != 0.0 {
            var keyword = ""
            if totalMoneyInPot > 0 {
                keyword = "Gained"
            }
            else {
                keyword = "Missing"
            }
            
            errorMessage = "Money not balanced: \(keyword) $\(abs(totalMoneyInPot))"
        }
    }
    
    func orderPlayerEntries() -> [PlayerEntry] {
        return playerEntries.sorted { $0.endingAmount > $1.endingAmount }
    }
    
    func addPlayer() {
        onNavigate(.addPlayerToNightScreen)
        print("Add Player")
    }
    
    func saveChosenDate() {
        if savedDates.isEmpty {
            context.insert(SavedDate(date: inputDate))
        }
        else {
            for savedDate in savedDates {
                context.delete(savedDate)
            }
            context.insert(SavedDate(date: inputDate))
        }
    }
}

#Preview {
    AddNightScreen(onNavigate: { _ in })
}
