//
//  NightEntryView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 31/10/2025.
//

import SwiftUI

struct NightEntryView: View {
    var nightEntry: NightEntry
    
    @State var minMoney: Double = 0.0
    @State var maxMoney: Double = 0.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack {
                Text(formatDateMedium(date: nightEntry.date))
                    .foregroundStyle(.white)
                    .font(.system(size: 20))
                    
                Spacer()
                
            }
            .background(Color.black)
            .cornerRadius(8)
            
            ForEach (orderPlayerEntries(playerEntries: nightEntry.playerEntries), id: \.self.id) { playerEntry in
                PlayerEntryNoBorder(
                    playerEntry: playerEntry,
                    color: colorForValue(
                        value: playerEntry.endingAmount,
                        minValue: minMoney,
                        maxValue: maxMoney,
                        neutral: playerEntry.startingAmount
                        )
                    )
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
        .onAppear() {
            
            (minMoney, maxMoney) = calculateMinMax(playerEntries: nightEntry.playerEntries)
        }
    }
    
    
}

#Preview {
    NightEntryView(nightEntry: getTestNightEntry())
}
