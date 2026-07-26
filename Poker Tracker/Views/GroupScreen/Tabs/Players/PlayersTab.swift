//
//  PlayerTab.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 26/2/2026.
//

import SwiftUI

struct PlayersTab: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var playerTotals: [PlayerTotals]
    @State var sortedPlayerTotals: [PlayerTotals] = []
    
    @State var selectedFilter: String = "Win Percentage"
    
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    FilterDropdownView(selectedFilter: $selectedFilter)
                    Spacer()
                }
                
                VStack {
                    ForEach(sortedPlayerTotals, id: \.id) { playerTotal in
                        PlayerValueDisplay(
                            selectedFilter: $selectedFilter,
                            playerTotals: playerTotal
                        )
                        
                        Divider()
                            .padding(.leading, 16)
                    }
                }
                .padding(.top, 10)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
        }
        .padding(.horizontal, 10)
        .onAppear() {
            sortedPlayerTotals = playerTotals.sorted {
                $0.value(for: selectedFilter) > $1.value(for: selectedFilter)
            }
        }
        .onChange(of: playerTotals) {
            sortedPlayerTotals = playerTotals.sorted {
                $0.value(for: selectedFilter) > $1.value(for: selectedFilter)
            }
        }
        .onChange(of: selectedFilter) { 
            sortedPlayerTotals = playerTotals.sorted {
                $0.value(for: selectedFilter) > $1.value(for: selectedFilter)
            }
        }
    }
    
}

struct PlayersTabPreview: View {
    @State var playerTotals: [PlayerTotals] = []
    var body: some View {
        PlayersTab(playerTotals: $playerTotals)
    }
}

#Preview {
    PlayersTabPreview()
}
