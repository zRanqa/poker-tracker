//
//  SessionView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 2/3/2026.
//

import SwiftUI



struct SessionView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var pokerSession: PokerSession
    @State var orderedNightEntries: [PlayerNightEntry] = []
    
    var body: some View {
        VStack {
            HStack {
                Text(formatDate(date: pokerSession.date))
                    .font(.system(size: 20, weight: .bold))
                Spacer()
            }
            Grid(horizontalSpacing: 8, verticalSpacing: 4) {
                ForEach(orderedNightEntries) { playerNightEntry in
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
        }
        
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 3)
        )
        .padding(.horizontal, 10)
        .onAppear {
            orderedNightEntries = Array(pokerSession.playerNightEntries).sorted { $0.endAmount > $1.endAmount }
        }
    }
}

#Preview {
    SessionView(pokerSession: getTestPokerSession())
}
