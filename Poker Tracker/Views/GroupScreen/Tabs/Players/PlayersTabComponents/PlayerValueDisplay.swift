//
//  PlayerValueDisplay.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/2/2026.
//

import SwiftUI

struct PlayerValueDisplay: View {
    var playerTotals: PlayerTotals

    var body: some View {
        Button(action: {
            
        }) {
            HStack {
                Text(playerTotals.name)
                    .font(.body)

                Spacer()

                Text(playerTotals.winPercentage.description)
                    .font(.body)
                    .foregroundStyle(.secondary)

                Image(systemName: "chevron.right")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.tertiary)
            }
            .padding(.horizontal, 16)
            .frame(minHeight: 44)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .foregroundStyle(.primary)
    }
}

#Preview {
    PlayerValueDisplay(playerTotals: PlayerTotals(id: "3", name: "bob", totalMoney: 20.0))
}
