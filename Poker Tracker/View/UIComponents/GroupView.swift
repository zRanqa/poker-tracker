//
//  GroupView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 24/12/2025.
//

import SwiftUI

struct GroupView: View {
    
    var pokerGroup: PokerGroup
    var onTap: () -> Void
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(pokerGroup.name)
                            .font(.title)
                            .foregroundStyle(.orange)
                        Spacer()
                        HStack() {
                            Text("+$100")
                                .foregroundStyle(.green)
                        }
                    }
                    Spacer()
                    
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundStyle(.orange)
                        .font(.system(size: 40))
                }
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 70, maxHeight: 100)
            .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray))
        }
    }
}

#Preview {
    GroupView(pokerGroup: PokerGroup(id: 1, created_at: "", name: "test name"), onTap: {})
}
