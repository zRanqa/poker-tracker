//
//  AddPlayerToNightView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 3/3/2026.
//

import SwiftUI

struct AddEntryToSessionView: View {
    @Environment(\.dismiss) private var dismiss

    var onSave: (SessionEntry) -> Void
    @Binding var idNumber: Int

    @State private var selectedPlayer = ""
    @State private var startAmount = ""
    @State private var endAmount = ""
    @State private var buyIns = ""
    @State private var errorMessage: String = ""
    
    // So the struct works to save the entry using an escaping function
    init(idNumber: Binding<Int>, onSave: @escaping (SessionEntry) -> Void) {
        self._idNumber = idNumber
        self.onSave = onSave
    }

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
                    Button(action: {
                        if selectedPlayer.isEmpty || startAmount.isEmpty || endAmount.isEmpty || buyIns.isEmpty {
                            errorMessage = "All fields must be filled in."
                            return
                        }
                        let entry = SessionEntry(
                            id: String(idNumber),
                            groupMember: getRandomGroupMember(),
                            startAmount: Double(startAmount) ?? 0,
                            endAmount: Double(endAmount) ?? 0,
                            buyIns: Int(buyIns) ?? 0
                        )

                        idNumber += 1
                        onSave(entry)
                        dismiss()
                    }
                    ) {
                        Text("Save")
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

struct AddEntryToSessionViewPreview: View {
    @State var sessionEntries: [SessionEntry] = []
    @State var idNumber: Int = 0
    var body : some View {
        AddEntryToSessionView(idNumber: $idNumber) { newEntry in
            sessionEntries.append(newEntry)
        }
    }
}

#Preview {
    AddEntryToSessionViewPreview()
}
