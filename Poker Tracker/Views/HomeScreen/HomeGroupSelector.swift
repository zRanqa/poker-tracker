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
            VStack {
                VStack {
                    HStack {
                        VStack {
                            Text(group.name)
                                .font(.system(size: 30, weight: .bold, design: .default))
                                .padding()
                            Spacer()
                            
                        }
                        Spacer()
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.system(size: 50))
                            .padding(.trailing, 20)
                    }
                    Spacer()
                    HStack {
                        Text("+$1300")
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 3)
                            )
                            .padding()
                        Spacer()
                    }
                }
            }
            .foregroundStyle(.black )
            .frame(maxWidth: .infinity, maxHeight: 180)
            .background(group.color)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 3)
            )
        }
    }
}

#Preview {
    HomeGroupSelector(onNavigate: { _ in }, group: PokerGroup(id: "1", name: "Test Group", color: Color(red: 240/255, green: 229/255, blue: 132/255)))
        .padding()
}
