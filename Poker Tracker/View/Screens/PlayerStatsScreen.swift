//
//  PlayerStatsScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 19/11/2025.
//

import SwiftUI

struct PlayerStatsScreen: View {
    
    var onNavigate: (AppScreen) -> Void
    
    @State private var playerTotals : [PlayerTotals] = []
    
    @State private var selectedPlayerName: String = "Player"
    @State private var allPlayersString: [String] = ["Player"]
    
    @State private var attrList: [String : String] = [:]
    
    @State private var selectedColumn: String = "Select a Stat"
    @State private var selectedKey: String = ""
    @State private var allColumnsString: [String] = ["Select a Stat"]
    
    var body: some View {
        
        VStack {
            VStack {
                Text("Player Stats")
                    .font(.title)
                    .padding(.bottom, 10)
                
                HStack {
                    
                    Picker("Name", selection: $selectedPlayerName) {
                        ForEach(allPlayersString, id: \.self) { player in
                            Text(player)
                        }
                    }
                    .tint(.orange)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray))
                    
                    Button(action: {
                        if selectedPlayerName != "Player" {
                            for playerTotal in playerTotals {
                                if playerTotal.playerDetails.name == selectedPlayerName {
                                    onNavigate(.individualStatsScreen(playerTotal))
                                    break
                                }
                            }
                        }
                    }) {
                        Text("View Stats")
                            .tint(.green)
                            .frame(width: 140, height: 35)
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray)
                            )
                        
                    }
                }
                .padding(.bottom, 30)
                
                
                Picker("Stat", selection: $selectedColumn) {
                    ForEach(allColumnsString, id: \.self) { player in
                        Text(player)
                    }
                }
                .onChange(of: selectedColumn) {
                    selectedKey = displayToKey[selectedColumn] ?? ""
                    reorderTotals()
                }
                .tint(.orange)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray))
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach (playerTotals, id: \.self.id) { playerTotal in
                            PlayerTotalView(playerTotals: playerTotal, selectedColumn: $selectedKey).padding(.vertical, 5)
                        }
                    }
                    .padding(.vertical, 10)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                    .padding(.vertical, 5)
                }
            }
            .padding(.horizontal, 15)
            
            Spacer()
            
            BottomBar(onNavigate: onNavigate)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            Task {
                do {
                    
                    let players = try await loadAllPlayerDetails()
                    for player in players {
                        allPlayersString.append(player.name)
                    }
                    
                    playerTotals = await calculateTotals()
                    attrList = getPlayerTotalAttributes()
                    for attr in attrList {
                        allColumnsString.append(attrList[attr.0] ?? "")
                    }
                }
            }
        }
    }
    
    func valueForKey(_ key: String, in totals: PlayerTotals) -> Double {
        let mirror = Mirror(reflecting: totals)

        for child in mirror.children {
            if let label = child.label, label == key {
                return Double(String(describing: child.value)) ?? 0
            }
        }
        return 0
    }
    
    func reorderTotals() {
        guard !selectedKey.isEmpty else { return }

        playerTotals.sort {
            valueForKey(selectedKey, in: $0) >
            valueForKey(selectedKey, in: $1)
        }
    }

    
    var displayToKey: [String : String] {
        Dictionary(uniqueKeysWithValues: attrList.map { ($0.value, $0.key) })
    }
}


#Preview {
    PlayerStatsScreen(onNavigate: { _ in})
}
