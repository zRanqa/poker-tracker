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
                    onNavigate(.homeScreen)
                }) {
                    Image(systemName: "house")
                        .font(.system(size: iconSize))
                }
                Spacer()
                
                Button(action: {
                    onNavigate(.playerStatsScreen)
                }) {
                    Image(systemName: "chart.bar.xaxis")
                        .font(.system(size: iconSize))
                }
                Spacer()
                Button(action: {
                    onNavigate(.addNightScreen)
                }) {
                    Image(systemName: "plus.app.fill")
                        .font(.system(size: 50))
                }
                Spacer()
                Button(action: {
                    onNavigate(.allGamesScreen)
                }) {
                    Image(systemName: "info.circle.text.page")
                        .font(.system(size: iconSize))
                }
                
                Spacer()
                Button(action: {
                    onNavigate(.playersScreen)
                }) {
                    Image(systemName: "person.circle")
                        .font(.system(size: iconSize))
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
