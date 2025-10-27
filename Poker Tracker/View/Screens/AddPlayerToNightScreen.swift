//
//  AddNightScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/10/2025.
//

import SwiftUI

struct AddPlayerToNightScreen: View {
    
    var onNavigate: (AppScreen) -> Void
    
    @State private var selectedName = "Select"
    
    let options = ["Select", "Jonathan", "Zaki"]
    
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
                    Picker("Name", selection: $selectedName) {
                        ForEach(options, id: \.self) { option in
                            Text(option)
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
                
                
                VStack(spacing: 20) {
                    Button(action: {
//                         Save details
                        let status = validateInputs()
                        if status.isSuccess {
                            
                            let playerEntry = PlayerEntry(
                                playerDetails: PlayerDetails(name: selectedName),
                                startingAmount: Double(startingAmount)!,
                                endingAmount: Double(endingAmount)!,
                                buyIns: Int(buyIns)!
                            )
                            
                            onNavigate(.addNightScreen)
                            
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
                        onNavigate(.addNightScreen)
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
        var status: Status
        
        if selectedName == "Select" {
            return Status(isSuccess: false, message: "Please select a name")
        }
        
        status = validateInput(input: startingAmount, validateDouble: true)
        if status.isSuccess == false {
            return status
        }
        
        status = validateInput(input: endingAmount, validateDouble: true)
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
