//
//  ErrorMessage.swift
//  a1-s4092185-s4008144
//
//  Created by Jonathan Dummett on 30/8/2025.
//

import SwiftUI

struct ErrorMessage: View {
    var message: String
    
    var body: some View {
        Text("⚠️ Error: \(message)")
            .foregroundColor(.red)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.red.opacity(0.1))
            .cornerRadius(6)
            .transition(.move(edge: .top).combined(with: .opacity))
            .padding(.bottom, 10)
    }
}

#Preview {
    ErrorMessage(message: "Input must be a number")
}
