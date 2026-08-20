//
//  PlayerValueDisplay.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/2/2026.
//

import SwiftUI

struct PlayerValueDisplay: View {
    @Binding var selectedFilter: String
    var playerTotals: PlayerTotals
    
    @Binding var selectedPlayerTotals: PlayerTotals?

    var body: some View {
        Button(action: {
            selectedPlayerTotals = playerTotals
        }) {
            HStack {
                Text(playerTotals.name)
                    .font(.body)

                Spacer()

                Text(playerTotals.label(for: selectedFilter))
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

struct PlayerValueDisplayPreview: View {
    
    @State var selectedFilter: String = "Total Money"
    @State var selectedPlayerTotals: PlayerTotals? = nil
    
    var body: some View {
        PlayerValueDisplay(selectedFilter: $selectedFilter,playerTotals: PlayerTotals(id: UUID(), name: "bob", totalMoney: 20.0), selectedPlayerTotals: $selectedPlayerTotals)
    }
}

#Preview {
    PlayerValueDisplayPreview()
}
