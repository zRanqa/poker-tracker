//
//  PlayerNightRow.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 3/3/2026.
//

import SwiftUI

struct PlayerNightRow: View {
    
    var playerNightEntry: PlayerNightEntry
    
    var body: some View {
        HStack {
            Grid(horizontalSpacing: 8, verticalSpacing: 4) {
                GridRow {
                    Text(playerNightEntry.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(formatMoney(amount: playerNightEntry.startAmount))
                        .frame(width: 60, alignment: .trailing)
                    
                    Text(formatMoney(amount: playerNightEntry.endAmount))
                        .frame(width: 60, alignment: .trailing)
                        .foregroundStyle(
                            playerNightEntry.endAmount < playerNightEntry.startAmount
                            ? .red : .green
                        )
                    Text(formatDifference(amount:
                                            playerNightEntry.endAmount - playerNightEntry.startAmount
                                         ))
                    .frame(width: 70, alignment: .trailing)
                    .foregroundStyle(
                        playerNightEntry.endAmount < playerNightEntry.startAmount
                        ? .red : .green
                    )
                }
            }
    
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .border(Color.blue, width: 1)
    }
}

#Preview {
    PlayerNightRow(playerNightEntry: getTestPlayerNightEntry())
}
