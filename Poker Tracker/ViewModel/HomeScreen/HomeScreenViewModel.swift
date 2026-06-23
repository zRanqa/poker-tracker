//
//  HomeScreenViewModel.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 23/6/2026.
//


import Foundation
import Observation


@Observable
class HomeScreenViewModel {
    
    func getGroups(token: String) async -> [PokerGroup] {
        do {
            let pokerGroups = try await fetchGroups(token: token)
            return pokerGroups
        } catch {
            print(error)
            return []
        }
    }
}
