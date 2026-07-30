//
//  ResetPasswordInputEmailView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 30/7/2026.
//

import SwiftUI

struct ResetPasswordInputEmailView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var email: String
    @Binding var resetPasswordState: ResetPasswordState
    @State var errorMessage = ""
    @State var isLoading = false
    
    var lightBackground: Color = Color(red: 0.9, green: 0.9, blue: 0.9)
    var darkBackground: Color = Color(red: 0.1, green: 0.1, blue: 0.1)
    
    var lightText: Color = Color(red: 0.7, green: 0.7, blue: 0.7)
    var darkText: Color = Color(red: 0.4, green: 0.4, blue: 0.4)
    
    var vm: ResetPasswordViewModel
    
    var body: some View {
        VStack {
            Text("Enter an Email")
                .font(.title)
            
            TextField("Email", text: $email)
                .font(.subheadline)
                .tint(.orange)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity)
                .padding(15)
                .background(colorScheme == .light ? lightBackground : darkBackground)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(colorScheme == .light ? lightText : darkText, lineWidth: 2)
                )
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
                .padding(.bottom, 10)
            
            
            if errorMessage.isEmpty == false {
                Text(errorMessage)
                    .font(.body)
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 5)
            }
            
            LoginSignupButton(text: "Reset Password", onTap: {
                
                if email.isEmpty {
                    errorMessage = "Please enter an email"
                    return
                }
                guard email.contains("@"), email.contains(".") else {
                    errorMessage = "Please enter a valid email"
                    return
                }
                
                isLoading = true
                print(isLoading)
                Task {
                    errorMessage = await vm.getVerificationCode(email: email)
                    if errorMessage == "" {
                        resetPasswordState = .verificationCode
                    }
                    isLoading = false
                }
            }, isLoading: $isLoading)
            
        }
        .padding(.horizontal, 30)
    }
}
