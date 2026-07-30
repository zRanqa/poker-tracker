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
}

struct LoginScreen: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appState: AppState
    
    @State private var loginState: LoginState = .loginSignup
    
    var onNavigate: (AppScreen) -> Void
    
    @State var email: String = "jonnoach@gmail.com"
    @State var password: String = "securePassword1"
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
            
            if loginState == .loginSignup {
                LoginSignupForm(
                    onNavigate: onNavigate,
                    loginState: $loginState,
                    email: $email,
                    password: $password,
                    name: $name
                )
                    .padding(.horizontal, 30)
            }
            else {
                VerificationCodeView(
                    onNavigate: onNavigate,
                    loginState: $loginState,
                    email: $email,
                    password: $password,
                    name: $name
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

