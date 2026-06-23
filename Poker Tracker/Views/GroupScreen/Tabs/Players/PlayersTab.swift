//
//  PlayerTab.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 26/2/2026.
//

import SwiftUI

struct PlayersTab: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var selectedFilter: String = "Win Percentage"
    
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    FilterDropdownView(selectedFilter: $selectedFilter)
                    Spacer()
                }
                
                VStack {
                    ForEach(0...10, id: \.self) { i in
                        PlayerValueDisplay(playerTotals: PlayerTotals(id: "\(i)", name: "Player \(i)", totalMoney: 20))
                        
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
    }
}

#Preview {
    PlayersTab()
}
