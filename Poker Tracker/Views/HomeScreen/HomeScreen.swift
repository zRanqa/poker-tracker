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
    
    @State var showCreateGroupSheet = false
    
    var vm = HomeScreenViewModel()
    
    func loadGroups() {
        Task {
            guard let token = try? await appState.validAccessToken() else {
                return
            }
            groups = await vm.getGroups(token: token)
            groups.append(getTestGroup())
        }
    }
    
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
                    
                    Button(action: {
                        showCreateGroupSheet = true
                    }) {
                        Text("Create a Group")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 180)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.secondary, lineWidth: 3)
                            )
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal)
            }
            Spacer()
            BottomBarView(onNavigate: onNavigate)
        }
        .task {
            loadGroups()
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $showCreateGroupSheet) {
            CreateGroupFormView(loadGroups: loadGroups)
                .presentationDetents([.height(450)])
        }
    }
}

#Preview {
    HomeScreen(onNavigate: { _ in })
}
