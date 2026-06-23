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
    
    @State private var email: String = "Test"
    @State private var emailValid: Bool = true
    
    @State private var password: String = ""
    @State private var passwordValid: Bool = true
    
    @State private var name: String = ""
    @State private var nameValid: Bool = true
    
    
    @State private var state: currState = .login
    @State private var isLoading: Bool = false
    
    @State private var accountPrompt: String = "Don't have an account?"
    @State private var accountButtonLabel: String = "Sign up!"
    @State private var loginSignupButtonLabel: String = "Login!"
    
    
    private let lightBackground: Color = Color(red: 0.9, green: 0.9, blue: 0.9)
    private let darkBackground: Color = Color(red: 0.1, green: 0.1, blue: 0.1)
    
    private let lightText: Color = Color(red: 0.7, green: 0.7, blue: 0.7)
    private let darkText: Color = Color(red: 0.4, green: 0.4, blue: 0.4)
    
    func confirmButton() {
        if state == .login {
            onNavigate(.homeScreen)
        }
        else {
            loginState = .verification
        }
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
                
                
                LoginSignupButton(text: loginSignupButtonLabel, onTap: confirmButton, isLoading: $isLoading)
                
                
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
    var body: some View {
        
        LoginSignupForm(onNavigate: {_ in}, loginState: $loginState)
    }
}

#Preview {
    LoginSignupFormPreview()
}
