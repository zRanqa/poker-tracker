//
//  BottomBarView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 5/7/2026.
//

import SwiftUI

struct BottomBarView: View {
    @EnvironmentObject var appState: AppState
    var onNavigate: (AppScreen) -> Void
    var iconSize: CGFloat = 30
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    appState.groupId = nil
                    onNavigate(.homeScreen)
                }) {
                    Image(systemName: "house")
                        .font(.system(size: iconSize))
                }
                Spacer()
                Button(action: {
                    appState.groupId = nil
                    onNavigate(.homeScreen)
                }) {
                    Image(systemName: "info.circle.text.page")
                        .font(.system(size: iconSize))
                }
                
                Spacer()
                Button(action: {
                    onNavigate(.loginScreen)
                }) {
                    Image(systemName: "person.circle")
                        .font(.system(size: iconSize))
                }
                Spacer()
                
            }
            .padding(.vertical, 30)
            .background(Color(.systemGray5))
            .foregroundColor(.orange)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            .shadow(radius: 5)
        }
    }
}

#Preview {
    BottomBarView(onNavigate: {_ in})
}
