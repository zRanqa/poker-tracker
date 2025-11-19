//
//  PlayerTotalView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 19/11/2025.
//

import SwiftUI

struct PlayerTotalView: View {
    
    var playerTotals: PlayerTotals
    @Binding var selectedColumn: String
    
    var body: some View {
        VStack {
            
            HStack {
                HStack(spacing: 0) {
                    Text(playerTotals.playerDetails.name)
                        .frame(width: 160, alignment: .leading)
                        .padding(.horizontal, 8)
                        .foregroundStyle(.orange)
                    
                    
                    Divider()
                        .frame(height: 20)
                        .background(Color.white.opacity(0.8))
                    
                    Text(displayColumn)
                        .frame(width: 150, alignment: .trailing)
                        .padding(.horizontal, 8)
                        .foregroundStyle(.white)
                    
                }
                .padding(.horizontal, 15)
            }
        }
    }
    
    var displayColumn: String {
        let mirror = Mirror(reflecting: playerTotals)

        for child in mirror.children {
            if let label = child.label, label == selectedColumn {
                
                let number = Double(String(describing: child.value)) ?? 0
                
                switch selectedColumn {
                case "totalMoney", "mostMoneyWon", "mostMoneyLost":
                    return formatAmount(amount: number)
                    
                case "winPercentage", "lossPercentage":
                    return formatPercentage(amount: number)
                    
                default:
                    return String(describing: child.value)
                }
            }
        }
        
        return ""
    }
}

struct PlayerTotalViewPreview: View {
    var playerTotals: PlayerTotals = PlayerTotals(playerDetails: getTestPlayerDetails(), totalMoney: 0)
    @State var selectedColumn: String = "winPercentage"
    
    var body: some View {
        PlayerTotalView(playerTotals: playerTotals, selectedColumn: $selectedColumn)
    }
}

#Preview {
    PlayerTotalViewPreview()
}
