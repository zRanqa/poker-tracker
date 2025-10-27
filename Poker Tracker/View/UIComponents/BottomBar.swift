//
//  BottomBar.swift
//  a1-s4092185-s4008144
//
//  Created by Jonathan Dummett on 23/8/2025.
//

import SwiftUI

struct BottomBar: View {
    var onNavigate: (AppScreen) -> Void
    var iconSize: CGFloat = 30
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
//                    onNavigate(.home)
                }) {
                    Image(systemName: "house")
                        .font(.system(size: iconSize))
                        .shadow(color: Color.white.opacity(0.8), radius: 4, x: 0, y: 0)
                }
                Spacer()
                Button(action: {
//                    onNavigate(.search)
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: iconSize))
                        .shadow(color: Color.white.opacity(0.8), radius: 4, x: 0, y: 0)
                }
                Spacer()
                Button(action: {
//                    onNavigate(.myBookings)
                }) {
                    Image(systemName: "info.circle.text.page")
                        .font(.system(size: iconSize))
                        .shadow(color: Color.white.opacity(0.8), radius: 4, x: 0, y: 0)
                }
                Spacer()
                
            }
            .padding(.vertical, 30)
            .background(Color(.systemGray5))
            .foregroundColor(Color(.label))
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            .shadow(radius: 5)
        }
    }
}

#Preview {
    BottomBar(onNavigate: { _ in })
}
