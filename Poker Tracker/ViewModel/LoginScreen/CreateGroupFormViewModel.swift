//
//  CreateGroupFormViewModel.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 30/7/2026.
//

import Foundation
import Observation
import SwiftUI

@Observable
class CreateGroupFormViewModel {
    func createGroup(token: String, name: String, color: Color) async -> String {
        do {
            let response = try await HomeScreenAPI.createGroup(token: token, name: name, color: color)
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
