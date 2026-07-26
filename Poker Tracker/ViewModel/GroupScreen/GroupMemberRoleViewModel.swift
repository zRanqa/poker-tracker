//
//  GroupMemberRoleViewModel.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 7/7/2026.
//

import Foundation
import Observation

@Observable
class GroupMemberRoleViewModel {
    func removeGroupMember(token: String, groupId: Int, groupMember: GroupMember) async -> String {
        do {
            if groupMember.isGuest {
                let response = try await GroupScreenAPI.removeGuestMemberDB(token: token, groupId: groupId, id: groupMember.id)
                if response.status == "error" {
                    return response.message
                }
            }
            else {
                let response = try await GroupScreenAPI.removeUserFromGroup(token: token, groupId: groupId, userId: groupMember.id)
                if response.status == "error" {
                    return response.message
                }
            }
            
            return ""
        } catch {
            print(error)
            return error.localizedDescription
        }
    }
}
