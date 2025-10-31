//
//  DatePicker.swift
//  a1-s4092185-s4008144
//
//  Created by Jonathan Dummett on 30/8/2025.
//

import SwiftUI

struct PlayerEntryNoBorder: View {
    
    var playerEntry: PlayerEntry
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack {
                HStack(spacing: 0) {
                    Text(playerEntry.playerDetails.name)
                        .frame(width: 160, alignment: .leading)
                        .padding(.horizontal, 8)
                        .foregroundStyle(.orange)
                    
                    
                    Divider()
                        .frame(height: 20)
                        .background(Color.white.opacity(0.8))
                    
                    Text(formatAmount(amount: playerEntry.startingAmount))
                        .frame(width: 70, alignment: .trailing)
                        .padding(.horizontal, 8)
                        .foregroundStyle(.white)
                    
                    Divider()
                        .frame(height: 20)
                        .background(Color.white.opacity(0.8))
                    
                    Text(formatAmount(amount: playerEntry.endingAmount))
                        .frame(width: 70, alignment: .trailing)
                        .padding(.horizontal, 8)
                        .foregroundStyle(color)
                }
                
            }
        
        }
    }
}


#Preview {
    let testPlayerEntry = getTestPlayerEntry()
    PlayerEntryNoBorder(
        playerEntry: testPlayerEntry,
        color: colorForValue(value: testPlayerEntry.endingAmount, minValue: 0, maxValue: 40, neutral: testPlayerEntry.startingAmount)
    )
}
