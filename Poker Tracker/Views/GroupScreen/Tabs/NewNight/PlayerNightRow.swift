//
//  PlayerNightRow.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 3/3/2026.
//

import SwiftUI

struct PlayerNightRow: View {
    
    var playerNightEntry: PlayerNightEntry
    
    private func determineColor(startAmount: Double, endAmount: Double) -> Color {
        if endAmount < startAmount {
            return .red
        }
        else if endAmount > startAmount {
            return .green
        }
        else {
            return .gray
        }
    }
    
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
                        .foregroundStyle(determineColor(startAmount: playerNightEntry.startAmount, endAmount: playerNightEntry.endAmount))
                    Text(formatDifference(amount:
                                            playerNightEntry.endAmount - playerNightEntry.startAmount
                                         ))
                    .frame(width: 70, alignment: .trailing)
                    .foregroundStyle(determineColor(startAmount: playerNightEntry.startAmount, endAmount: playerNightEntry.endAmount))
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
