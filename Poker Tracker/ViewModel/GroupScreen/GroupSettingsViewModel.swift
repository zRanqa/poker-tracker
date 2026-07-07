//
//  GroupSettingsViewModel.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 7/7/2026.
//


import Foundation
import Observation

@Observable
class GroupSettingsViewModel {
    func updateGroupName(token: String, groupId: Int, name: String) async -> String {
        do {
            let response = try await updateGroupNameDB(token: token, groupId: groupId, name: name)
            return response.status
        } catch {
            print(error)
            return ""
//            return error.localizedDescription
        }
    }
}
