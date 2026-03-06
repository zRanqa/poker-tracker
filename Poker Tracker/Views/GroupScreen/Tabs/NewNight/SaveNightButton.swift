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
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
            
            
                .background(Color(red: 100/255, green: 255/255, blue: 100/255))
            
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(red: 60/255, green: 200/255, blue: 60/255), lineWidth: 3)
                )
        }
    }
}

#Preview {
    SaveNightButton(onTap: {})
}
