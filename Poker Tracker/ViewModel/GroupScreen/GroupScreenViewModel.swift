//
//  GroupScreenViewModel.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 28/6/2026.
//

import Foundation
import Observation

@Observable
class GroupScreenViewModel {
    
    func getGroupDetails(token: String, group: PokerGroup) async -> PokerGroup {
        
        var newGroup = group
        do {
            // Get group members
            newGroup.groupMembers = try await fetchGroupMembers(token: token, groupId: group.id)
            
            // get sessions
            newGroup.pokerSessions = try await fetchGroupSessions(token: token, groupId: group.id, groupMembers: newGroup.groupMembers)
            print(newGroup.groupMembers.count)
        } catch {
            print("error at groupScreenViewModel")
            print(error)
        }
        
        return newGroup
    }
    
    func getPlayerTotals(group: PokerGroup) -> [PlayerTotals] {
        return []
    }
}
