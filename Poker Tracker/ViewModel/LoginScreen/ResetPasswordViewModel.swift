//
//  ResetPasswordViewModel.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 30/7/2026.
//

import Foundation
import Observation


@Observable
class ResetPasswordViewModel {
    func getVerificationCode(email: String) async -> String {
        do {
            let response = try await LoginSignupAPI.createResetPasswordCode(email: email)
            if response.status == "error" {
                return response.message
            }
            return ""
        } catch {
            print(error)
            return error.localizedDescription
        }
    }
    
    func confirmVerificationCode(email: String, code: String) async -> String {
        do {
            let response = try await LoginSignupAPI.confirmVerificationCode(email: email, code: code)
            if response.status == "error" {
                return response.message
            }
            return ""
        } catch {
            print(error)
            return error.localizedDescription
        }
    }
    func updatePassword(email: String, password: String) async -> String {
        do {
            let response = try await LoginSignupAPI.updatePassword(email: email, password: password)
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
