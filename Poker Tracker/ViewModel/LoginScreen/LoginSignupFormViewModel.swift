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
            let loginDTO = try await LoginSignupAPI.loginFromApi(email: email, password: password)
            print(loginDTO)
            if loginDTO != nil {
                if loginDTO!.status == "error" {
                    return loginDTO!.message
                    
                }
                else {
                    if loginDTO?.tokens != nil && loginDTO?.user != nil {
                        appState.login(
                            user: loginDTO!.user!,
                            token: loginDTO!.tokens!.access_token,
                            refreshToken: loginDTO!.tokens!.refresh_token
                        )
                        return ""
                    }
                    return "Error with data"
                }
            }
            
        } catch {
            print(error)
            return "Error with server"
        }
        return ""
    }
    
    func createVerificationCode(email: String) async -> String {
        do {
            let respone = try await LoginSignupAPI.createVerificationCode(email: email)
            if respone != nil {
                if respone!.status == "error" {
                    return respone!.message
                }
            }
            return ""
        } catch {
            print(error)
            return error.localizedDescription
        }
    }
    
    
    func validatePassword(_ password: String) -> String {
        var hasUppercase = false
        var hasLowercase = false
        var hasNumber = false
        var hasSpecialChar = false
        
        let specialCharacters = Set("!@#$%&?")
        
        for char in password {
            if char.isUppercase {
                hasUppercase = true
            }
            if char.isLowercase {
                hasLowercase = true
            }
            if char.isNumber {
                hasNumber = true
            }
            if specialCharacters.contains(char) {
                hasSpecialChar = true
            }
        }
        
        var missingRequirements: [String] = []
        
        if password.count < 8 {
            missingRequirements.append("be at least 8 characters long")
        }
        if !hasUppercase {
            missingRequirements.append("contain an uppercase letter")
        }
        if !hasLowercase {
            missingRequirements.append("contain a lowercase letter")
        }
        if !hasNumber {
            missingRequirements.append("contain a number")
        }
        if !hasSpecialChar {
            missingRequirements.append("contain a special character: !@#$%&?")
        }
        
        if missingRequirements.isEmpty {
            return ""
        }
        
        return "Password must " + missingRequirements.first!
    }
}
