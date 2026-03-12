//
//  SessionView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 2/3/2026.
//

import SwiftUI



struct SessionView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var pokerSession: PokerSession
    @State var orderedSessionEntries: [SessionEntry] = []
    
    var body: some View {
        VStack {
            HStack {
                Text(formatDate(date: pokerSession.date))
                    .font(.system(size: 20, weight: .bold))
                Spacer()
            }
            Grid(horizontalSpacing: 8, verticalSpacing: 4) {
                ForEach(orderedSessionEntries) { sessionEntry in
                    GridRow {
                        Text(sessionEntry.groupMember.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(formatMoney(amount: sessionEntry.startAmount))
                            .frame(width: 60, alignment: .trailing)
                        
                        Text(formatMoney(amount: sessionEntry.endAmount))
                            .frame(width: 60, alignment: .trailing)
                            .foregroundStyle(
                                sessionEntry.endAmount < sessionEntry.startAmount
                                ? .red : .green
                            )
                        Text(formatDifference(amount:
                                                sessionEntry.endAmount - sessionEntry.startAmount
                                             ))
                        .frame(width: 70, alignment: .trailing)
                        .foregroundStyle(
                            sessionEntry.endAmount < sessionEntry.startAmount
                            ? .red : .green
                        )
                    }
                }
            }
        }
        
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 3)
        )
        .padding(.horizontal, 10)
        .onAppear {
            orderedSessionEntries = Array(pokerSession.sessionEntries).sorted { $0.endAmount > $1.endAmount }
        }
    }
}

#Preview {
    SessionView(pokerSession: getTestPokerSession())
}
