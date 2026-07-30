//
//  LoginSingupForm.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 2/4/2026.
//

import SwiftUI

enum currState {
    case login
    case signup
}

struct LoginSignupForm: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appState: AppState
    
    var onNavigate: (AppScreen) -> Void
    @Binding var loginState: LoginState
    
    @Binding var email: String
    @State private var emailValid: Bool = true
    
    @Binding var password: String
    @State private var passwordValid: Bool = true
    
    @Binding var name: String
    @State private var nameValid: Bool = true
    
    
    @State private var state: currState = .login
    @State private var isLoading: Bool = false
    
    @State private var accountPrompt: String = "Don't have an account?"
    @State private var accountButtonLabel: String = "Sign up!"
    @State private var loginSignupButtonLabel: String = "Login!"
    
    @State private var errorMessage: String = ""
    
    
    var lightBackground: Color = Color(red: 0.9, green: 0.9, blue: 0.9)
    var darkBackground: Color = Color(red: 0.1, green: 0.1, blue: 0.1)
    
    var lightText: Color = Color(red: 0.7, green: 0.7, blue: 0.7)
    var darkText: Color = Color(red: 0.4, green: 0.4, blue: 0.4)
    
    private let vm = LoginSignupFormViewModel()
    
    @State private var showResetPasswordPrompt = false
    
    
    func confirmButton() {
        
        guard email.contains("@"), email.contains(".") else {
            errorMessage = "Please enter a valid email"
            return
        }
        guard !password.isEmpty else {
            errorMessage = "Please enter a password"
            return
        }
        
        
        errorMessage = ""
        if state == .login {
            isLoading = true
            Task {
                errorMessage = await vm.login(email: email, password: password, appState: appState)
                if errorMessage != "" {
                    showResetPasswordPrompt = true
                }
            }
        }
        else {
            guard password.count < 30 else {
                errorMessage = "Password must be under 30 characters"
                return
            }
            let passwordError = vm.validatePassword(password)
            if passwordError != "" {
                errorMessage = passwordError
                return
            }
            
            guard !name.isEmpty else {
                errorMessage = "Please enter a name"
                return
            }
            guard name.count < 30 else {
                errorMessage = "Name must be under 30 characters"
                return
            }
            isLoading = true
            Task {
                errorMessage = await vm.createVerificationCode(email: email)
                if errorMessage == "" {
                    loginState = .verification
                }
            }
        }
        isLoading = false
    }
    
    func toggleState() {
        if state == .login {
            state = .signup
            
            accountPrompt = "Already have an account?"
            accountButtonLabel = "Log in!"
            loginSignupButtonLabel = "Sign up!"
            
        }
        else {
            state = .login
            
            accountPrompt = "Don't have an account?"
            accountButtonLabel = "Sign up!"
            loginSignupButtonLabel = "Login!"
        }
        
        
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                if state == .signup {
                    TextField("Firstname", text: $name)
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
                }
                
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
                
                
                SecureField("Password", text: $password)
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
                
                if errorMessage.isEmpty == false {
                    Text(errorMessage)
                        .font(.body)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 5)
                }
                
                LoginSignupButton(
                    text: loginSignupButtonLabel,
                    onTap: confirmButton,
                    isLoading: $isLoading
                )
                
                if showResetPasswordPrompt {
                    
                    HStack(spacing: 4) {
                        Text("Forgot your password?")
                            .font(.subheadline)
                        Button(action: {
                            loginState = .resetPassword(email)
                        }) {
                            Text("Reset Password!")
                                .font(.subheadline)
                                .foregroundStyle(Color.orange)
                        }
                    }
                    .opacity(1)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.25), value: showResetPasswordPrompt)
                }
                HStack(spacing: 4) {
                    Text(accountPrompt)
                        .font(.subheadline)
                    Button(action: toggleState) {
                        Text(accountButtonLabel)
                            .font(.subheadline)
                            .foregroundStyle(Color.orange)
                    }
                }
                .opacity(1)
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.25), value: accountPrompt)
            }
        }
        .opacity(1)
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.25), value: accountPrompt)
    }
}

struct LoginSignupFormPreview: View {
    @State var loginState: LoginState = .loginSignup
    @State var name = ""
    @State var email = ""
    @State var password = ""
    var body: some View {
        
        LoginSignupForm(onNavigate: {_ in}, loginState: $loginState, email: $email, password: $password, name: $name)
    }
}

#Preview {
    LoginSignupFormPreview()
}
