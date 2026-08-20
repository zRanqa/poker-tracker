//
//  ResetPasswordView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 30/7/2026.
//

import SwiftUI

enum ResetPasswordState {
    case inputEmail
    case verificationCode
    case newPassword
}

struct ResetPasswordView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appState: AppState
    
    var onNavigate: (AppScreen) -> Void
    @Binding var loginState: LoginState
    @State var email: String
    
    
    var lightBackground: Color = Color(red: 0.9, green: 0.9, blue: 0.9)
    var darkBackground: Color = Color(red: 0.1, green: 0.1, blue: 0.1)
    
    var lightText: Color = Color(red: 0.7, green: 0.7, blue: 0.7)
    var darkText: Color = Color(red: 0.4, green: 0.4, blue: 0.4)
    
    @State private var errorMessage: String = ""
    @State var resetPasswordState: ResetPasswordState = .inputEmail
    
    var vm = ResetPasswordViewModel()
    
    var body: some View {
        switch resetPasswordState {
        case .inputEmail:
            ResetPasswordInputEmailView(
                email: $email,
                resetPasswordState: $resetPasswordState,
                vm: vm
            )
        case .verificationCode:
            ResetPasswordVerificationCodeView(
                email: $email,
                resetPasswordState: $resetPasswordState,
                vm: vm
            )
        case .newPassword:
            ResetPasswordNewPassword(
                email: $email,
                loginState: $loginState,
                vm: vm
            )
        }
        HStack {
            Button(action: {
                loginState = .loginSignup
            }) {
                HStack {
                    Image(systemName: "arrowshape.backward")
                    Text("Back to Login")
                }
                .padding(10)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 24, style: .continuous).stroke(.white.opacity(0.25), lineWidth: 1)
                }
                .shadow(radius: 12)
            }
            Spacer()
        }
        .padding(.leading, 30)
        
    }
}

struct ResetPasswordViewPreview: View {
    @State var loginState = LoginState.resetPassword("")
    var body: some View {
        ResetPasswordView(
            onNavigate: {_ in}, loginState: $loginState, email: "")
        
    }
}

#Preview {
    ResetPasswordViewPreview()
}
