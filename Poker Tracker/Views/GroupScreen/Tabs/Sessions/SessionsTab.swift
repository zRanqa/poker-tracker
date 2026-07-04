//
//  SessionsTab.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 26/2/2026.
//

import SwiftUI

struct SessionsTab: View {
    
    @Binding var groupSessions: [PokerSession]
    var sortedGroupSessions: [PokerSession] {
        groupSessions.sorted { $0.date > $1.date }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(sortedGroupSessions, id: \.id) { pokerSession in
                    SessionView(pokerSession: pokerSession)
                }
                
            }
            .padding(.top, 10)
            .padding(.bottom, 20)
            .padding(.horizontal, 10)
        }
    }
}

struct SessionsTabPreview: View {
    @State var groupSessions = [getTestPokerSession(id: 1), getTestPokerSession(id: 2), getTestPokerSession(id: 3), getTestPokerSession(id: 4)]
    var body: some View {
        SessionsTab(groupSessions: $groupSessions)
    }
}

#Preview {
    SessionsTabPreview()
}
