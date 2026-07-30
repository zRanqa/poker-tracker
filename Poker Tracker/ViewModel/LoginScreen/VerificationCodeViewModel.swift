//
//  VerificationCodeViewModel.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 30/7/2026.
//
import Foundation
import Observation


@Observable
class VerificationCodeViewModel {
    func signupNewAccount(email: String, password: String, name: String, code: String) async -> String {
        
        do {
            let response = try await LoginSignupAPI.signupNewAccount(email: email, password: password, name: name, code: code)
            if response != nil {
                if response!.status == "error" {
                    return response!.message
                }
                return ""
            }
            return "Error"
            
        } catch {
            print(error)
            return error.localizedDescription
        }
    }
}
