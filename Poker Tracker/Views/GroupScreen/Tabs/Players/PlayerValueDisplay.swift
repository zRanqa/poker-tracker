//
//  PlayerValueDisplay.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/2/2026.
//

import SwiftUI

struct PlayerValueDisplay: View {
    @Environment(\.colorScheme) var colorScheme
    
    var playerTotals: PlayerTotals
    
    var body: some View {
        Button(action: {
            
        }) {
            HStack(spacing: 0) {
                HStack {
                    Text(playerTotals.name)
                    Spacer()
                }
                .frame(height: 30)
                .padding(.horizontal, 10)
                .border(colorScheme == .dark ? Color.white : Color.black, width: 1)
                .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
                
                HStack {
                    Text(playerTotals.winPercentage.description)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                
                .frame(height: 30)
                .padding(.horizontal, 10)
                .border(colorScheme == .dark ? Color.white : Color.black, width: 1)
                .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
                
            }
        }
    }
}

#Preview {
    PlayerValueDisplay(playerTotals: PlayerTotals(id: "3", name: "bob", totalMoney: 20.0))
}
