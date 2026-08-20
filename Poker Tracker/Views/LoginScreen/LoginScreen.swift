//
//  LoginScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 21/12/2025.
//

import SwiftUI
import SwiftData

enum LoginState {
    case loginSignup
    case verification
    case resetPassword(String)
}

struct LoginScreen: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appState: AppState
    
    @State private var loginState: LoginState = .loginSignup
    
    var onNavigate: (AppScreen) -> Void
    
    @State var email: String = "jonnoach@gmail.com"
    @State var password: String = "securePassword1!"
    @State var name: String = ""
    
    
    var body: some View {
        VStack {
            
            HStack {
                Image(systemName: "chart.xyaxis.line")
                Text("Poker Tracker")
            }
            .font(.system(size: 40))
            .padding(.top, 100)
            .padding(.bottom, 40)
            .bold(true)
            
            switch loginState {
            case .loginSignup:
                LoginSignupForm(
                    onNavigate: onNavigate,
                    loginState: $loginState,
                    email: $email,
                    password: $password,
                    name: $name
                )
                    .padding(.horizontal, 30)
            case .verification:
                VerificationCodeView(
                    onNavigate: onNavigate,
                    loginState: $loginState,
                    email: $email,
                    password: $password,
                    name: $name
                )
            case .resetPassword(let email):
                ResetPasswordView(
                    onNavigate: onNavigate,
                    loginState: $loginState,
                    email: email
                )
            }
            
            Spacer()
        }
        .task {
            await appState.initLogin()
        }
    }
} 


#Preview {
    LoginScreen(onNavigate: { _ in })
}

