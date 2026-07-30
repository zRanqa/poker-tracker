//
//  ResetPasswordNewPassword.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 30/7/2026.
//

import SwiftUI

struct ResetPasswordNewPassword: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appState: AppState
    
    @Binding var email: String
    @Binding var loginState: LoginState
    
    @State var errorMessage = ""
    @State var isLoading = false
    
    var lightBackground: Color = Color(red: 0.9, green: 0.9, blue: 0.9)
    var darkBackground: Color = Color(red: 0.1, green: 0.1, blue: 0.1)
    
    var lightText: Color = Color(red: 0.7, green: 0.7, blue: 0.7)
    var darkText: Color = Color(red: 0.4, green: 0.4, blue: 0.4)
    
    @State var newPassword: String = ""
    @State var confirmPassword: String = ""
    
    @State var showAlert = false
    
    var loginSignupVM = LoginSignupFormViewModel()
    var vm: ResetPasswordViewModel
    
    func updatePassword() {
        guard newPassword.count < 30 else {
            errorMessage = "Password must be under 30 characters"
            return
        }
        let passwordError = loginSignupVM.validatePassword(newPassword)
        if passwordError != "" {
            errorMessage = passwordError
            return
        }
        
        if newPassword != confirmPassword {
            errorMessage = "Password do not match"
            return
        }
        isLoading = true
        Task {
            errorMessage = await vm.updatePassword(email: email, password: newPassword)
            if errorMessage == "" {
                showAlert = true
            }
            isLoading = false
        }
    }
    
    var body: some View {
        VStack {
            
            Text("New Password")
                .font(.title)
            
            SecureField("Password", text: $newPassword)
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
                .padding(.bottom, 5)
            
            SecureField("Confirm password", text: $confirmPassword)
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
            
            LoginSignupButton(
                text: "Update Password",
                onTap: updatePassword,
                isLoading: $isLoading)
        }
        .padding(.horizontal, 30)
        .alert("Password Updated!", isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                loginState = .loginSignup
            }
        }
    }
}
