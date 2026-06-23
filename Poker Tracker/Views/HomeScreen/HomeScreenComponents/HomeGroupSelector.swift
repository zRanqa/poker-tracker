//
//  GroupSelector.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 24/2/2026.
//

import SwiftUI

struct HomeGroupSelector: View {
    
    var onNavigate: (AppScreen) -> Void
    
    var group: PokerGroup
    
    var body: some View {
        Button(action: {
            onNavigate(.groupScreen(group))
        }) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top) {
                    Text(group.name)
                        .font(.system(size: 28, weight: .bold))
                        .lineLimit(1)

                    Spacer()

                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 24, weight: .semibold))
                }

                Spacer(minLength: 0)

                Text("+$1300")
                    .font(.subheadline.weight(.semibold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 24, style: .continuous).stroke(.white.opacity(0.25), lineWidth: 1)
                    }
                    .shadow(radius: 12)
            }
            
            .padding(20)
            .frame(maxWidth: .infinity, minHeight: 140, maxHeight: 180)
            .background(group.color)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 24, style: .continuous).stroke(.white.opacity(0.25), lineWidth: 1)
            }
            .shadow(radius: 12)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeGroupSelector(onNavigate: { _ in }, group: PokerGroup(id: 1, name: "Test Group", color: Color(red: 240/255, green: 229/255, blue: 132/255)))
        .padding()
}
