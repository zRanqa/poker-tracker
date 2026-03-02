//
//  SessionsTab.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 26/2/2026.
//

import SwiftUI

struct SessionsTab: View {
    
    @State var groupSessions: [PokerSession] = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(groupSessions, id: \.id) { pokerSession in
                    SessionView(pokerSession: pokerSession)
                }
            }
        }
        
        .onAppear() {
            groupSessions = [getTestPokerSession(), getTestPokerSession(), getTestPokerSession(), getTestPokerSession()]
        }
    }
        
}

#Preview {
    SessionsTab()
}
