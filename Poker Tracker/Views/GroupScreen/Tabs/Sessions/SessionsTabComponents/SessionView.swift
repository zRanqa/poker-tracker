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
                        Text("Name")
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
        
        .padding(15)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous).stroke(.white.opacity(0.25), lineWidth: 1)
        }
        .shadow(radius: 5)
        .onAppear {
            orderedSessionEntries = Array(pokerSession.sessionEntries).sorted { $0.endAmount > $1.endAmount }
        }
    }
}

#Preview {
    SessionView(pokerSession: getTestPokerSession())
}
