//
//  OverviewPlayerCard.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 26/2/2026.
//

import SwiftUI

struct OverviewPlayerCard: View {
    @Environment(\.colorScheme) var colorScheme
    
    var playerTotals: PlayerTotals
    
    var onNavigate: (AppScreen) -> Void
    
    var body: some View {
        Button(action: {onNavigate(.homeScreen)}) {
            VStack() {
                HStack {
                    Text(playerTotals.name)
                        .font(.system(size: 20))
                        .padding(.top, 10)
                        .padding(.leading, 10)
                    
                    Spacer()
                }
                
                HStack {
                    Text(playerTotals.winPercentage.description + "%")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.leading, 10)
                    Spacer()
                }
                HStack {
                    Text("Win Percentage")
                        .font(.system(size: 15, weight: .bold))
                        .padding(.leading, 10)
                    Spacer()
                }
                
                HStack {
                    Text("🔥" + playerTotals.winStreak.description + " win streak")
                        .font(.system(size: 13))
                        .padding(.leading, 10)
                    Spacer()
                }
                
                
                HStack {
                    Text("💰$" + playerTotals.totalMoney.description)
                        .font(.system(size: 13))
                        .padding(.leading, 10)
                    Spacer()
                }
                
                HStack {
                    Text("🎲" + playerTotals.buyIns.description + " Buy-ins")
                        .font(.system(size: 13))
                        .padding(.leading, 10)
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    Text("View more")
                    Image(systemName: "arrowshape.right.fill")
                }
                .padding(.bottom, 10)
                .padding(.trailing, 10)
            }
            
            .padding(5)
            .frame(width: 170, height: 170)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 24, style: .continuous).stroke(.white.opacity(0.25), lineWidth: 1)
            }
            .shadow(radius: 12)
        }
        .tint(.primary)
    }
}

#Preview {
    OverviewPlayerCard(playerTotals: PlayerTotals(id: UUID(), name: "Bob", totalMoney: 20.0), onNavigate: { _ in})
}
