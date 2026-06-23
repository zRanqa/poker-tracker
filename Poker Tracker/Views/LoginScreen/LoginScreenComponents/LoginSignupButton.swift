//
//  LoginSingupButton.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 2/4/2026.
//

import SwiftUI

struct LoginSignupButton: View {
    var text: String
    var onTap: () -> Void
    @Binding var isLoading: Bool
    
    var body: some View {
        Button(action: onTap) {
            ZStack {
                if isLoading {
                    ProgressView("")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.2)
                        .padding(.top, 15)
                }
                else {
                    Text(text)
                        .foregroundColor(.primary)
                        .fontWeight(.semibold)
                }
            }
            .frame(height: 20)
            .frame(maxWidth: .infinity)
            .padding(12)
            .background(Color.orange)
            .cornerRadius(8)
//            .shadow(color: Color.white.opacity(0.8), radius: 4, x: 0, y: 0)
        }
        
    }
}

struct loginSignupButtonPreview: View {
    @State var isLoading: Bool = false
    
    var body: some View {
        LoginSignupButton(text: "Login", onTap: {}, isLoading: $isLoading)
    }
}

#Preview {
    loginSignupButtonPreview()
}
