//
//  AddPlayerToNightView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 3/3/2026.
//

import SwiftUI

struct AddPlayerToNightView: View {
    @Environment(\.dismiss) private var dismiss

    var onSave: (PlayerNightEntry) -> Void
    

    @State private var selectedPlayer = ""
    @State private var startAmount = ""
    @State private var endAmount = ""
    @State private var buyIns = ""
    
    @State var errorMessage: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Picker("Player", selection: $selectedPlayer) {
                        Text("Player 1").tag("Player 1")
                        Text("Player 2").tag("Player 2")
                    }
                    
                    TextField("Start Amount", text: $startAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("End Amount", text: $endAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Buy-ins", text: $buyIns)
                        .keyboardType(.numberPad)
                }
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
                Spacer()
            }
            .navigationTitle("Add Player")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if selectedPlayer.isEmpty || startAmount.isEmpty || endAmount.isEmpty || buyIns.isEmpty {
                            errorMessage = "All fields must be filled in."
                            return
                        }
                        let entry = PlayerNightEntry(
                            id: UUID().uuidString,
                            name: selectedPlayer,
                            startAmount: Double(startAmount) ?? 0,
                            endAmount: Double(endAmount) ?? 0,
                            buyIns: Int(buyIns) ?? 0
                        )

                        onSave(entry)
                        dismiss()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}

struct AddPlayerToNightViewPreview: View {
    @State var playerNightEntries: [PlayerNightEntry] = []
    var body : some View {
        AddPlayerToNightView { newEntry in
            playerNightEntries.append(newEntry)
        }
    }
}

#Preview {
    AddPlayerToNightViewPreview()
}
