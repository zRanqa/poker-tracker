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
    
    @State var maxMoney: Double = 0.0
    @State var minMoney: Double = 0.0
    
    @State var areYouSure: Bool = false
    @State var buttonText: String = "Add Night"
    
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
                                    PlayerEntryView(
                                        playerEntry: playerEntry,
                                        color: colorForValue(
                                            value: playerEntry.endingAmount,
                                            minValue: minMoney,
                                            maxValue: maxMoney,
                                            neutral: playerEntry.startingAmount
                                            )
                                        )
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
                    
                    WideButton(name: buttonText, color: .green, onTap: addNight)
                    
//                    WideButton(name: "Cancel", color: .red, onTap: {})
                }
                .padding(.horizontal, 10)
                
                BottomBar(onNavigate: onNavigate)
            }
            .onAppear() {
                if !savedDates.isEmpty {
                    inputDate = savedDates.first!.date
                }
                
                if !playerEntries.isEmpty {
                    
                    minMoney = playerEntries.first!.endingAmount
                    maxMoney = playerEntries.first!.endingAmount
                    
                    for player in playerEntries {
                        if player.endingAmount > maxMoney {
                            maxMoney = player.endingAmount
                        }
                        if player.endingAmount < minMoney {
                            minMoney = player.endingAmount
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func addNight() {
        
        // Validate the night
        
        // Check if there are any players
        if playerEntries.isEmpty {
            errorMessage = "No players added"
            return
        }
        
        
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
            return
        }
        
        if !areYouSure {
            areYouSure = true
            buttonText = "Are you Sure?"
        }
        else {
            // save
            // TODO: GET RID OF ALL THE DATA IN SWIFTDATA
            // TODO: (DELETE THE CURRENT NIGHT ENTRY)
            let nightEntry = NightEntry(date: inputDate, playerEntries: playerEntries)
            Task {
                try await saveNightEntry(nightEntry: nightEntry)
            }
            print("Save Night")
            onNavigate(.allGamesScreen)
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
