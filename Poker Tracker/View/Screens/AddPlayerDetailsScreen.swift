//
//  AddNightScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/10/2025.
//

import SwiftUI

struct AddPlayerDetailsScreen: View {
    
    var onNavigate: (AppScreen) -> Void
    
    @State private var name: String = ""
    
    @State var errorMessage: String = ""
    
    var body: some View {
        VStack {
            Text("Add Player Details")
                .font(.title)
                .padding(.bottom)
            
            
            
            VStack {
                HStack {
                    Text("Name: ")
                        .font(.title2)
                    Spacer()
                }
                TextField("name", text: $name)
                    .tint(.orange)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray)
                    )
                
//                
//                HStack {
//                    Text("Starting Amount: ")
//                        .font(.title2)
//                    TextField("0.0", text: $startingAmount)
//                        .tint(.orange)
//                        .frame(maxWidth: .infinity)
//                        .padding(.horizontal, 10)
//                        .padding(.vertical, 5)
//                        .background(RoundedRectangle(cornerRadius: 8)
//                            .stroke(Color.gray)
//                        )
//                }
//                
//                
//                HStack {
//                    Text("Ending Amount:   ")
//                        .font(.title2)
//                    TextField("0.0", text: $endingAmount)
//                        .tint(.orange)
//                        .frame(maxWidth: .infinity)
//                        .padding(.horizontal, 10)
//                        .padding(.vertical, 5)
//                        .background(RoundedRectangle(cornerRadius: 8)
//                            .stroke(Color.gray)
//                        )
//                }
                
                Spacer()
                
                if !errorMessage.isEmpty {
                    ErrorMessage(message: errorMessage)
                }
                
                
                VStack(spacing: 20) {
                    Button(action: {
                        let status = validateInputs()
                        if status.isSuccess {
                            Task {
                                // First test if the player already exists
                                let playerExists = try await doesPlayerDetailsExist(name: name)
                                
                                if playerExists {
                                    errorMessage = "Player already exists"
                                    return
                                }
                                else {
                                    // If they dont exist, add player to database and exit
                                    let newPlayer = PlayerDetails(name: name)
                                    try await savePlayerDetails(playerDetails: newPlayer)
                                    onNavigate(.playersScreen)
                                }
                            }
                        }
                        else {
                            errorMessage = status.message
                        }
                    }) {
                        Text("Add Player")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(8)
                            .shadow(color: Color.white.opacity(0.8), radius: 4, x: 0, y: 0)
                    }
                    
                    Button(action: {
                        onNavigate(.playersScreen)
                    }) {
                        Text("Cancel")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                            .shadow(color: Color.white.opacity(0.8), radius: 4, x: 0, y: 0)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            
            BottomBar(onNavigate: onNavigate)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func validateInputs() -> Status {
        return validateInput(input: name, validateName: true)
    }

}

#Preview {
    AddPlayerDetailsScreen(onNavigate: { _ in })
}
