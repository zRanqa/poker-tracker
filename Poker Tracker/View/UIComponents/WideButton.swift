//
//  WideButton.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 29/10/2025.
//

import SwiftUI

struct WideButton: View {
    
    var name: String
    var color: Color
    var onTap: () -> Void
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            Text(name)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .semibold))
                .frame(maxWidth: .infinity)
                .padding()
                .background(color)
                .cornerRadius(8)
                .shadow(color: Color.white.opacity(0.8), radius: 4, x: 0, y: 0)
        }
    }
}

#Preview {
    WideButton(name: "Save", color: .green, onTap: { })
    WideButton(name: "Cancel", color: .red, onTap: { })
}
