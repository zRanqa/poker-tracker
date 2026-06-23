//
//  VerificationCodeView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 2/4/2026.
//

import SwiftUI

struct VerificationCodeView: View {
    
    var onNavigate: (AppScreen) -> Void
    @Binding var loginState: LoginState
    
    @State private var errorMessage: String = ""
    
    @State private var isLoading: Bool = false
    @State private var verifictionCode: Bool = false
    @State private var codeInput = ""
    
    func confirmCode() {
        errorMessage = ""
        
        let filteredCode = codeInput.filter { $0.isNumber }
        if filteredCode.count < 6 {
            errorMessage = "Please enter a valid code!"
            return
        }
        
        isLoading = true
//        if savedUserInfo == nil {
//            errorMessage = "User info is nil??"
//            return
//        }
        
        onNavigate(.homeScreen)
    }
    
    var body: some View {
        
            Text("6 Digit Code")
                .font(.title)
            Text("A verification code has been sent to your email!")
                .font(.subheadline)
            
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
                .background(Color(red: 0.1, green: 0.1, blue: 0.1))
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


struct VerificationCodeViewPreview: View {
    @State var loginState: LoginState = .verification
    var body: some View {
        
        VerificationCodeView(onNavigate: {_ in}, loginState: $loginState)
    }
}


#Preview {
    VerificationCodeViewPreview()
}
