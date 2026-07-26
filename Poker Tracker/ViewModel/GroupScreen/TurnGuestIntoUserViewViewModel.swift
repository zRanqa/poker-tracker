//
//  TurnGuestIntoUserViewViewModel.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 20/7/2026.
//

import Foundation
import Observation

@Observable
class TurnGuestIntoUserViewViewModel {
    func turnGuestIntoUser(token: String, groupId: Int, guestId: UUID, userEmail: String) async -> String {
        do {
            let response = try await GroupScreenAPI.turnGuestIntoUser(token: token, groupId: groupId, guestId: guestId, userEmail: userEmail)
            if response.status == "error" {
                return response.message
            }
            return ""
        } catch {
            print(error)
            return error.localizedDescription
        }
    }
}
