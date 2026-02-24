//
//  GroupScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 24/2/2026.
//

import SwiftUI

struct HomeScreen: View {
    
    var onNavigate: (AppScreen) -> Void
    
    var groups: [PokerGroup] = [
        PokerGroup(id: "1", name: "Test Group", color: Color(red: 240/255, green: 229/255, blue: 132/255)),
        
        PokerGroup(id: "2", name: "Test Group 2", color: Color(red: 240/255, green: 141/255, blue: 100/255)),
        
        PokerGroup(id: "3", name: "Test Group 3", color: Color(red: 240/255, green: 141/255, blue: 100/255)),
        PokerGroup(id: "4", name: "Test Group 4", color: Color(red: 240/255, green: 141/255, blue: 100/255)),
        PokerGroup(id: "5", name: "Test Group 5", color: Color(red: 240/255, green: 141/255, blue: 100/255))
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(groups) { group in
                        HomeGroupSelector(onNavigate: onNavigate, group: group)
                    }
                    Text("Join a Group")
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 180)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.secondary, lineWidth: 3)
                        )
                    
                    Text("Create a Group")
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 180)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.secondary, lineWidth: 3)
                        )
                }
                .padding(.horizontal)
            }
            Spacer()
                
        }
        
    }
}

#Preview {
    HomeScreen(onNavigate: { _ in })
}
