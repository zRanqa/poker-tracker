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
                .background(Color.textFieldBackground)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.textFieldText, lineWidth: 2)
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
