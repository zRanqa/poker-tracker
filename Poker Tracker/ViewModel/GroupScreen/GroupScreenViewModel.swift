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
        // Get group members
        
        // get sessions
        do {
            newGroup.pokerSessions = try await fetchGroupSessions(token: token, groupId: group.id)
            print(newGroup.pokerSessions.count)
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
