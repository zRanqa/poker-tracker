//
//  AddNightScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/10/2025.
//

import SwiftUI
import SwiftData

struct AddPlayerToNightScreen: View {
    @Environment(\.modelContext) private var context
    @Query var playerEntries: [PlayerEntry] = []
    
    var onNavigate: (AppScreen) -> Void
    
    @State private var allPlayers: [PlayerDetails] = []
    
    @State private var selectedPlayerName: String = "Select"
    @State private var allPlayersString: [String] = ["Select"]
    
    @State private var startingAmount: String = ""
    @State private var endingAmount: String = ""
    @State private var buyIns: String = ""
    
    @State var errorMessage: String = ""
    
    var body: some View {
        VStack {
            Text("Add Player to Night")
                .font(.title)
                .padding(.bottom)
            
            
            
            VStack {
                HStack {
                    Text("Name: ")
                        .font(.title2)
                    Picker("Name", selection: $selectedPlayerName) {
                        ForEach(allPlayersString, id: \.self) { player in
                            Text(player)
                        }
                    }
                    .tint(.orange)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray))
                }
                
                
                HStack {
                    Text("Starting Amount: ")
                        .font(.title2)
                    TextField("0.0", text: $startingAmount)
                        .tint(.orange)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray)
                        )
                }
                
                
                HStack {
                    Text("Ending Amount:   ")
                        .font(.title2)
                    TextField("0.0", text: $endingAmount)
                        .tint(.orange)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray)
                        )
                }
                
                HStack {
                    
                    Text("Buy-Ins:")
                        .font(.title2)
                    TextField("0", text: $buyIns)
                        .tint(.orange)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray)
                        )
                }
                
                Spacer()
                
                if !errorMessage.isEmpty {
                    ErrorMessage(message: errorMessage)
                }
                
                VStack {
                    
                    WideButton(name: "Add Player", color: .green, onTap: addPlayer)
                    
                    WideButton(name: "Cancel", color: .red, onTap: { onNavigate(.addNightScreen) })
                    
                }
            }
            .padding(.horizontal, 10)
            
            BottomBar(onNavigate: onNavigate)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            Task {
                do {
                    let players = try await loadAllPlayerDetails()
                    
                    DispatchQueue.main.async {
                        self.allPlayers = players
                        for player in allPlayers {
                            // If the player is already added to the night, dont add them
                            if playerEntries.contains(where: { $0.playerDetails.name == player.name }) {
                                continue
                            }
                            allPlayersString.append(player.name)
                        }
                    }
                }
            }
        }
    }
    
    func addPlayer() {
        let status = validateInputs()
        if status.isSuccess {
            
            let playerEntry = PlayerEntry(
                playerDetails: getPlayerDetailsFromInput(),
                startingAmount: Double(startingAmount)!,
                endingAmount: Double(endingAmount)!,
                buyIns: Int(buyIns)!
            )
            
            onNavigate(.addNightScreen)
            context.insert(playerEntry)
            
        }
        else {
            errorMessage = status.message
        }
    }
    
    func getPlayerDetailsFromInput() -> PlayerDetails {
        return allPlayers.first { $0.name == selectedPlayerName }!
    }
    
    func validateInputs() -> Status {
        var status: Status
        
        if selectedPlayerName == "Select" {
            return Status(isSuccess: false, message: "Please select a name")
        }
        
        status = validateInput(input: startingAmount, validateDouble: true, validatePositive: true)
        if status.isSuccess == false {
            return status
        }
        
        status = validateInput(input: endingAmount, validateDouble: true, validatePositive: true)
        if status.isSuccess == false {
            return status
        }
        
        status = validateInput(input: buyIns, validateInt: true)
        if status.isSuccess == false {
            return status
        }
        
        return Status(isSuccess: true, message: "")
    }

}

#Preview {
    AddPlayerToNightScreen(onNavigate: { _ in })
}
