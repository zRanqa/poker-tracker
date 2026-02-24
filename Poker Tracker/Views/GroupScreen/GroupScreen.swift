//
//  GroupScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 25/2/2026.
//

import SwiftUI

struct GroupScreen: View {
    
    var onNavigate: (AppScreen) -> Void
    
    var group: PokerGroup
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    GroupScreen(onNavigate: {_ in }, group: PokerGroup(id: "1", name: "Test Group", color: Color(red: 0.5, green: 0.5, blue: 0.5)))
}
