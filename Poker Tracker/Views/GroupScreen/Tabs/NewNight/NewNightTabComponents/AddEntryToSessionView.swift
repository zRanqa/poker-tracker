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
    var onDelete: ((SessionEntry) -> Void)?
    
    @Binding var idNumber: Int
    var groupMembers: [GroupMember]
    
    var sessionEntry: SessionEntry?
    @State private var selectedPlayer: GroupMember? = nil
    @State private var startAmount = ""
    @State private var endAmount = ""
    @State private var buyIns = ""
    @State private var errorMessage: String = ""
    @State private var showingDeleteConfirmation = false
    
    // So the struct works to save the entry using an escaping function
    init(idNumber: Binding<Int>, groupMembers: [GroupMember], sessionEntry: SessionEntry?, onSave: @escaping (SessionEntry) -> Void, onDelete: ((SessionEntry) -> Void)? = nil) {
        self._idNumber = idNumber
        self.onSave = onSave
        self.onDelete = onDelete
        self.groupMembers = groupMembers
        
        
        self.sessionEntry = sessionEntry
        if let entry = sessionEntry {
            self._selectedPlayer = State(initialValue: entry.groupMember)
            self._startAmount = State(initialValue: entry.startAmount.description)
            self._endAmount = State(initialValue: entry.endAmount.description)
            self._buyIns = State(initialValue: entry.buyIns.description)
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Picker("Player", selection: $selectedPlayer) {
                        if sessionEntry != nil {
                            Text(selectedPlayer!.name).tag(Optional(selectedPlayer!))
                        }
                        else {
                            Text("Select").tag(Optional<GroupMember>.none)
                            ForEach(groupMembers, id: \.id) { groupMember in
                                Text(groupMember.name).tag(Optional(groupMember))
                            }
                        }
                    }
                    
                    LabeledContent("Start Amount") {
                        TextField("Start Amount", text: $startAmount)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    LabeledContent("End Amount") {
                        TextField("End Amount", text: $endAmount)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    LabeledContent("Buy-ins") {
                        TextField("Buy-ins", text: $buyIns)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    if sessionEntry != nil {
                        Button(role: .destructive, action: {
                            showingDeleteConfirmation = true
                        }) {
                            Text("Delete Entry")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.red)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.red.opacity(0.4), lineWidth: 0.5)
                                )
                        }
                    }
                    
                }
                .multilineTextAlignment(.trailing)
                
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
                        guard let player = selectedPlayer else {
                            errorMessage = "Please select a player."
                            return
                        }
                        if startAmount.isEmpty || endAmount.isEmpty || buyIns.isEmpty {
                            errorMessage = "All fields must be filled in."
                            return
                        }
                        let entry = SessionEntry(
                            id: sessionEntry == nil ? String(idNumber) : sessionEntry!.id,
                            groupMember: player,
                            startAmount: Double(startAmount) ?? 0,
                            endAmount: Double(endAmount) ?? 0,
                            buyIns: Int(buyIns) ?? 0
                        )
                            
                        if sessionEntry == nil {
                            idNumber += 1
                        }
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
        .confirmationDialog("Delete Entry", isPresented: $showingDeleteConfirmation, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                if let entry = sessionEntry {
                    onDelete?(entry)
                    dismiss()
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to delete this entry?")
        }
    }
}

struct AddEntryToSessionViewPreview: View {
    @State var sessionEntries: [SessionEntry] = []
    @State var idNumber: Int = 0
    var groupMembers = [
        GroupMember(id: UUID(), name: "Player 1"),
        GroupMember(id: UUID(), name: "Player 2")
    ] as [GroupMember]
    var body : some View {
        AddEntryToSessionView(idNumber: $idNumber, groupMembers: groupMembers, sessionEntry: SessionEntry(id: "1", groupMember: getRandomGroupMember(), startAmount: 30, endAmount: 20, buyIns: 1)) { newEntry in
            sessionEntries.append(newEntry)
        }
    }
}

#Preview {
    AddEntryToSessionViewPreview()
}
