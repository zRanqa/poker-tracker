//
//  GroupScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 24/12/2025.
//

import SwiftUI

struct GroupScreen: View {
    @EnvironmentObject var appState: AppState
    
    var onNavigate: (AppScreen) -> Void
    
    @State var pokerGroups: [PokerGroup] = []
    
    var body: some View {
        VStack {
            VStack {
                Text("Your Groups")
                    .font(.title)
                    .padding(.bottom, 10)
                
                ScrollView {
                    VStack {
                        ForEach (pokerGroups, id: \.self.id) { pokerGroup in
                            GroupView(pokerGroup: pokerGroup, onTap: {})
                        }
                    }
                    .padding(.top, 5)
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            BottomBar(onNavigate: onNavigate)
                
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear() {
            Task {
                postRequest(to: API.getUserGroups.url, jsonBody: nil, token: appState.token) { (result: Result<APIResponse<[PokerGroup]>, Error>) in
//                    DispatchQueue.main.async {
//                        isLoading = false
//                    }
                    switch result {
                    case .success(let response):
                        print(response)
                        if response.status == "success" {
                            if response.data != nil {
                                print(response.data!)
                                pokerGroups = response.data!
                            }
                        }
                        else if response.status == "error" {
                        }
                    case .failure(let error):
                        print("Request failed:", error)
                    }
                }
            }
        }
    }
}

struct GroupScreenPreview: View {
    @StateObject var appState = AppState()
    
    var body: some View {
        
        GroupScreen(onNavigate: { _ in })
            .environmentObject(appState)
    }
}

#Preview {
    GroupScreenPreview()
}
