//
//  GroupScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 24/2/2026.
//

import SwiftUI

struct HomeScreen: View {
    var onNavigate: (AppScreen) -> Void
    @EnvironmentObject var appState: AppState
    
    
    @State var groups: [PokerGroup] = []
    
    var vm = HomeScreenViewModel()
    
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
            BottomBarView(onNavigate: onNavigate)
        }
        .task {
            groups = await vm.getGroups(token: appState.token ?? "")
            groups.append(getTestGroup())
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    HomeScreen(onNavigate: { _ in })
}
