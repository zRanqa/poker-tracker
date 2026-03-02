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
    var filters: [String] = ["Win Percentage", "Loss Percentage", "Buy Ins"]
    
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Picker("Select an option", selection: $selectedFilter) {
                        ForEach(filters, id: \.self) {
                            Text($0)
                                .foregroundStyle(.red)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(colorScheme == .dark ? Color.white : Color.black)
                    .border(colorScheme == .dark ? Color.white : Color.black, width: 1)
                    Spacer()
                }
                
                VStack {
                    ForEach(0...10, id: \.self) { i in
                        PlayerValueDisplay(playerTotals: PlayerTotals(id: "\(i)", name: "Player \(i)", totalMoney: 20))
                    }
                }
                
                
            }
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    PlayersTab()
}
