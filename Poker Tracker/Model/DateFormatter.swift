//
//  DateFormatter.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 31/10/2025.
//

import Foundation


func formatDateMedium(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
}

func getDateFromString(dateString: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    if let date = formatter.date(from: dateString) {
        return date
    }
    return Date()
}
