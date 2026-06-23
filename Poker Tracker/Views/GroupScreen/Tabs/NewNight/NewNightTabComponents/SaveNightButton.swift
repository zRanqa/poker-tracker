//
//  SaveNightButton.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 6/3/2026.
//

import SwiftUI

struct SaveNightButton: View {
    
    var onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text("Save Night")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.green.opacity(0.4), lineWidth: 0.5)
                )
        }
    }
}

#Preview {
    SaveNightButton(onTap: {})
}
