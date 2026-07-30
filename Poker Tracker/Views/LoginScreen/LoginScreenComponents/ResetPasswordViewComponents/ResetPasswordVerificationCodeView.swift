//
//  VerificationCodeView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 2/4/2026.
//

import SwiftUI

struct ResetPasswordVerificationCodeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var email: String
    @Binding var resetPasswordState: ResetPasswordState
    @State var errorMessage = ""
    @State var isLoading = false
    
    @State private var codeInput = ""
    
    var vm: ResetPasswordViewModel
    
    func confirmCode() {
        errorMessage = ""
        
        let filteredCode = codeInput.filter { $0.isNumber }
        if filteredCode.count < 6 {
            errorMessage = "Please enter a valid code!"
            return
        }
        
        isLoading = true
        Task {
            errorMessage = await vm.confirmVerificationCode(email: email, code: filteredCode)
            if errorMessage == "" {
                resetPasswordState = .newPassword
            }
            isLoading = false
        }
    }
    
    var body: some View {
        
            Text("6 Digit Code")
                .font(.title)
            Text("A verification code has been sent to your email!")
                .font(.subheadline)
            Text("(It might be in your spam folder!)")
                .font(.footnote)
            
            TextField("Enter code", text: $codeInput)
                .keyboardType(.numberPad)
                .onChange(of: codeInput) { oldValue, newValue in
                    let filtered = newValue.filter { $0.isNumber }
                    
                    if filtered.count > 6 {
                        codeInput = String(filtered.prefix(6))
                    } else {
                        codeInput = filtered
                    }
                }
                .multilineTextAlignment(.center)
                .font(.system(size: 24, weight: .semibold, design: .monospaced))
                .frame(maxWidth: 280)
                .padding(10)
                .background(colorScheme == .dark ?
                            Color(red: 0.1, green: 0.1, blue: 0.1) :
                            Color(red: 0.9, green: 0.9, blue: 0.9))
                .cornerRadius(8)
                .padding(.vertical, 5)
            
            if !errorMessage.isEmpty {
                Label {
                    Text(errorMessage)
                        .font(.subheadline)
                        .foregroundColor(.red)
                } icon: {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.red)
                }
                .opacity(errorMessage.isEmpty ? 0 : 1)
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.25), value: errorMessage)
            }
        
        
        LoginSignupButton(text: "Confirm", onTap: confirmCode, isLoading: $isLoading)
            .frame(maxWidth: 300)
            .opacity(1)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.25), value: "Confirm")
    }
}


struct ResetPasswordVerificationCodeViewPreview: View {
    @State var resetPasswordState: ResetPasswordState = .verificationCode
    @State var vm: ResetPasswordViewModel = .init()
    @State var email = ""
    var body: some View {
        
        ResetPasswordVerificationCodeView(email: $email, resetPasswordState: $resetPasswordState, vm: vm)
    }
}


#Preview {
    ResetPasswordVerificationCodeViewPreview()
}
