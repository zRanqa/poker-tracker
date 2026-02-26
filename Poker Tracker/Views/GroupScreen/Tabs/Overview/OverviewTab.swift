//
//  OverviewTab.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 26/2/2026.
//

import SwiftUI

struct OverviewTab: View {
    
    var onNavigate: (AppScreen) -> Void
    
    var body: some View {
        HStack {
            Spacer()
            OverviewPlayerCard(playerTotals: PlayerTotals(id: "1", name: "Bob", totalMoney: 20.0), onNavigate: onNavigate)
            Spacer()
            OverviewPlayerCard(playerTotals: PlayerTotals(id: "2", name: "jimmy", totalMoney: -20.0), onNavigate: onNavigate)
            Spacer()
        }
    }
}

#Preview {
    OverviewTab(onNavigate: { _ in})
}
