//
//  InviteNewUserViewViewModel.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 7/7/2026.
//

import Foundation
import Observation

@Observable
class InviteNewUserViewViewModel {
    func addUser(token: String, groupId: Int, email: String) async -> String {
        do {
            let response = try await addGroupMemberToGroup(token: token, groupId: groupId, email: email)
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
