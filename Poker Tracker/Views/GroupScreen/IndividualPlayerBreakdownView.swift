//
//  IndividualPlayerBreakdownView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 17/8/2026.
//

import SwiftUI

struct IndividualPlayerBreakdownView: View {
    @Environment(\.dismiss) private var dismiss
    var playerTotals: PlayerTotals
    var groupMember: GroupMember
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("\(groupMember.name)'s Stats")
                        .font(.title)
                    Spacer()
                }
                .padding(.leading, 15)
                
                PlayerTotalTimelineView(dollarAmounts: playerTotals.linePoints)
                
                HStack(spacing: 20) {
                    Spacer()
                    StatBubbleView(
                        title: "Games Played",
                        value: playerTotals.label(for: "Total Games"),
                        valueFont: .title,
                        width: 150,
                        height: 80
                    )
                    
                    StatBubbleView(
                        title: "Win Percentage",
                        value: playerTotals.label(for: "Win Percentage"),
                        valueFont: .title,
                        width: 150,
                        height: 80
                    )
                    Spacer()
                }
                HStack(spacing: 20) {
                    Spacer()
                    StatBubbleView(
                        title: "Games Won",
                        value: playerTotals.label(for: "Total Wins"),
                        valueFont: .title,
                        width: 150,
                        height: 80
                    )
                    
                    StatBubbleView(
                        title: "Games Lost",
                        value: playerTotals.label(for: "Total Losses"),
                        valueFont: .title,
                        width: 150,
                        height: 80
                    )
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    StatBubbleView(
                        title: "Buy Ins",
                        value: playerTotals.label(for: "Buy Ins"),
                        valueFont: .title3,
                        width: 100,
                        height: 70
                    )
                    StatBubbleView(
                        title: "Best Night",
                        value: playerTotals.label(for: "Most Money Won"),
                        valueFont: .title3,
                        width: 100,
                        height: 70
                    )
                    .foregroundStyle(.green)
                    StatBubbleView(
                        title: "Worst Night",
                        value: playerTotals.label(for: "Most Money Lost"),
                        valueFont: .title3,
                        width: 100,
                        height: 70
                    )
                    .foregroundStyle(.red)
                    Spacer()
                }
                
                if playerTotals.winStreak > 0 {
                    HStack(spacing: 0) {
                        Text("Currently on a \(playerTotals.winStreak)-game")
                        Text(" Win Streak!")
                            .foregroundStyle(Color.orange)
                    }
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 24, style: .continuous).stroke(.white.opacity(0.25), lineWidth: 1)
                    }
                    .shadow(radius: 12)
                }
                else if playerTotals.lossStreak > 0 {
                    HStack(spacing: 0) {
                        Text("Currently on a \(playerTotals.lossStreak)-game")
                        Text(" Loss Streak!")
                            .foregroundStyle(Color.cyan)
                    }
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 24, style: .continuous).stroke(.white.opacity(0.25), lineWidth: 1)
                    }
                    .shadow(radius: 12)
                }
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    IndividualPlayerBreakdownView(
        playerTotals: getTestPlayerTotals(), groupMember: getTestGroupMember()
    )
}
