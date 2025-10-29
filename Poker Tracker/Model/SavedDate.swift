//
//  SavedDate.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 29/10/2025.
//

import Foundation
import SwiftData

@Model
class SavedDate {
    var date: Date

    init(date: Date) {
        self.date = date
    }
}
