//
//  PlayerNightRow.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 3/3/2026.
//

import SwiftUI

struct PlayerNightRow: View {
    
    var sessionEntry: SessionEntry
    
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
                    Text(sessionEntry.groupMember.name)
                        .font(.body)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(formatMoney(amount: sessionEntry.startAmount))
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .frame(width: 60, alignment: .trailing)
                    
                    Text(formatMoney(amount: sessionEntry.endAmount))
                        .font(.body)
                        .fontWeight(.medium)
                        .frame(width: 60, alignment: .trailing)
                        .foregroundStyle(determineColor(startAmount: sessionEntry.startAmount, endAmount: sessionEntry.endAmount))
                    Text(formatDifference(amount:
                                            sessionEntry.endAmount - sessionEntry.startAmount
                                         ))
                    .font(.body)
                    .fontWeight(.semibold)
                    .frame(width: 70, alignment: .trailing)
                    .foregroundStyle(determineColor(startAmount: sessionEntry.startAmount, endAmount: sessionEntry.endAmount))
                }
            }
    
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity)
        
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.separator), lineWidth: 0.5)
        )
//        .frame(height: 50)
//        .border(Color.blue, width: 1)
    }
}

#Preview {
    PlayerNightRow(sessionEntry: getTestSessionEntry())
}
