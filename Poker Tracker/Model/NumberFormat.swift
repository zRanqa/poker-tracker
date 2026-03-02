//
//  NumberFormat.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 2/3/2026.
//

import Foundation


func formatMoney(amount: Double) -> String {
    // Format like $30 or  $10
    return amount.formatted(
        .currency(code: "AUD")
        .precision(.fractionLength(1...7))
    )
}

func formatDifference(amount: Double) -> String {
    // Format like +$30 or -$20
    return amount.formatted(
            .currency(code: "AUD")
            .precision(.fractionLength(1...7))
            .sign(strategy: .always())
        )
}

func formatDate(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
}
