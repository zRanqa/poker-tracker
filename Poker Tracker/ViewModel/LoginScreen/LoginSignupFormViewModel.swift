//
//  LoginSignupFormViewModel.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 23/6/2026.
//

import Foundation
import Observation


@Observable
class LoginSignupFormViewModel {
    
     
    // Returns error message!
    @MainActor
    func login(email: String, password: String, appState: AppState) async -> String {
        do {
            let loginDTO = try await loginFromApi(email: email, password: password)
            if loginDTO != nil {
                if loginDTO!.status == "error" {
                    return loginDTO!.message
                    
                }
                else {
                    if loginDTO?.data != nil {
                        appState.login(with: loginDTO!.data!)
                        return ""
                    }
                    return "Error with data"
                }
            }
            
        } catch {
            print(error)
        }
        return ""
    }
}
