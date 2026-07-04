//
//  NewNightTab.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 26/2/2026.
//

import SwiftUI

struct NewNightTab: View {
    @EnvironmentObject var appState: AppState
    
    var onNavigate: (AppScreen) -> Void
    var groupId: Int
    var groupMembers: [GroupMember]
    var loadGroup: () -> Void
    
    var filteredGroupMembers: [GroupMember] {
        groupMembers.filter { member in
            !sessionEntries.contains { $0.groupMember.id == member.id }
        }
    }
    
    @State private var errorMessage: String = ""
    @State private var nightDate: Date = Date()
    @State private var showingAddPlayer = false
    @State private var idNumber: Int = 0 // this is for the new session entrys
    
    @State private var selectedSessionEntry: SessionEntry?
    @State var sessionEntries: [SessionEntry] = []
    var sortedSessionEntries: [SessionEntry] {
        sessionEntries.sorted {
            ($0.endAmount - $0.startAmount) >
            ($1.endAmount - $1.startAmount)
        }
    }
    
    var vm = NewNightTabViewModel()
    
    func saveNight() async {
        // CHECK IF NIGHT VALID
        if sessionEntries.count < 2 {
            errorMessage = "Please add at least two players"
            return
        }
        
        
        var total = 0.0
        for sessionEntry in sessionEntries {
            total += (sessionEntry.endAmount - sessionEntry.startAmount)
        }
        if total != 0 {
            errorMessage = "Values are not balanced: $\(total)"
            return
        }
        
        if nightDate > Date() {
            errorMessage = "Cannot create a night in the future"
            return
        }
        
        errorMessage = ""
        
        let pokerSession = PokerSession(id: -1, date: nightDate, sessionEntries: sessionEntries)
        let response = await vm.saveNight(token: appState.token ?? "", groupId: groupId, pokerSession: pokerSession)
        if response.status == "error" {
            errorMessage = response.message
        }
        else {
            idNumber = 0 // reset back to 0 after saving the night
            sessionEntries = []
            nightDate = Date()
            loadGroup()
        }
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
                        Button(action: {
                            selectedSessionEntry = sessionEntry
                            showingAddPlayer = true
                        }) {
                            PlayerNightRow(sessionEntry: sessionEntry)
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                Button(action: {
                    selectedSessionEntry = nil
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
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }
            
            SaveNightButton(onTap: {
                Task {
                    await saveNight()
                }
            })
            
        }
        .padding(.horizontal, 10)
        .sheet(isPresented: $showingAddPlayer) {
            AddEntryToSessionView(
                idNumber: $idNumber,
                groupMembers: filteredGroupMembers,
                sessionEntry: selectedSessionEntry,
                onSave: { entry in
                    if let index = sessionEntries.firstIndex(where: { $0.id == entry.id }) {
                        sessionEntries[index] = entry
                    } else {
                        sessionEntries.append(entry)
                    }
                },
                onDelete: { entry in
                    sessionEntries.removeAll { $0.id == entry.id }
                }
            )
        }
    }
}

#Preview {
    NewNightTab(onNavigate: {_ in}, groupId: 1, groupMembers: [
        GroupMember(id: UUID(), name: "Player 1"),
        GroupMember(id: UUID(), name: "Player 2")], loadGroup: {})
}
