//
//  FilterDropdownView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 20/6/2026.
//

import SwiftUI

struct FilterDropdownView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var filters: [String] = [
        "Buy Ins",
        "Total Money",
        "Total Games",
        "Total Wins",
        "Total Losses",
        "Win Percentage",
        "Loss Percentage",
        "Win Streak",
        "Loss Streak",
        "Most Money Won",
        "Most Money Lost"
    ]
    
    @Binding var selectedFilter: String
    
    var body: some View {
        Picker("Select an option", selection: $selectedFilter) {
            ForEach(filters, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(.menu)
        .background(.ultraThinMaterial)
        .tint(.primary)
        
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            Capsule()
                .stroke(Color(.separator), lineWidth: 1)
        )
    }
}

struct FilterDropdownViewPreview: View {
    @State var selectedFilter: String = "Win Percentage"
    var body: some View {
        FilterDropdownView(selectedFilter: $selectedFilter)
    }
}

#Preview {
    FilterDropdownViewPreview()
}
