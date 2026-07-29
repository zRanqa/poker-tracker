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
            newGroup.groupMembers = try await GroupScreenAPI.fetchGroupMembers(token: token, groupId: group.id)
            
            // get sessions
            newGroup.pokerSessions = try await GroupScreenAPI.fetchGroupSessions(token: token, groupId: group.id, groupMembers: newGroup.groupMembers)
        } catch {
            print("error at groupScreenViewModel")
            print(error)
        }
        
        return newGroup
    }
    
    func getYearOptions(pokerSessions: [PokerSession]) -> [String] {
        var yearOptions = ["All"]
        for session in pokerSessions {
            let year = String(Calendar.current.component(.year, from: session.date))
            if !yearOptions.contains(year) {
                yearOptions.append(year)
            }
        }
        print(yearOptions)
        return yearOptions
    }
}
