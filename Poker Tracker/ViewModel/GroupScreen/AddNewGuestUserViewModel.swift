//
//  InviteNewUserViewViewModel.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 7/7/2026.
//

import Foundation
import Observation

@Observable
class AddNewGuestUserViewModel {
    func addGuest(token: String, groupId: Int, name: String) async -> String {
        do {
            let response = try await addGuestMemberToGroup(token: token, groupId: groupId, name: name)
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
