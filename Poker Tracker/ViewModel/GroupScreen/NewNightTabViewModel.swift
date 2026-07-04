//
//  NewNightTabViewModel.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 4/7/2026.
//

import Foundation
import Observation

@Observable
class NewNightTabViewModel {
    
    func saveNight(token: String, groupId: Int, pokerSession: PokerSession) async -> CreatePokerSessionResponse{
        do {
            let response = try await createPokerSession(token: token, groupId: groupId, pokerSession: pokerSession)
            return response
        } catch {
            print("error at groupScreenViewModel")
            print(error)
            return CreatePokerSessionResponse(status: "error", message: error.localizedDescription)
        }
    }
}



