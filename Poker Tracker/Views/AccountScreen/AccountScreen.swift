//
//  AccountScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 11/8/2026.
//

import SwiftUI

struct AccountScreen: View {
    @EnvironmentObject var appState: AppState
    var onNavigate: (AppScreen) -> Void
    
    @State var email: String = ""
//    private var name: String = ""
    
    var body: some View {
        VStack {
            Text("Account Settings")
            .font(.system(size: 40))
            .padding(.bottom, 40)
            .bold(true)
            
            HStack {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Email:")
                            .font(.title)
                        //                Text(appState.currUser?.email ?? "")
                        EditableTextFieldView(placeholder: "Email", text: $email)
                        
                        
                    }
                    .padding(.bottom, 30)
                    
                    VStack(alignment: .leading) {
                        Text("Name:")
                        //            Text(appState.currUser?.name ?? "")
                        Text("Name")
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            
            
            Button(action: {
                appState.logout()
                appState.currentScreen = .loginScreen
            }) {
                Text("Logout")
            }
            
            Spacer()
            BottomBarView(onNavigate: onNavigate)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
//            email = appState.currUser?.email ?? ""
            email = "email@email.com"
        }
    }
    
}

#Preview {
    AccountScreen(onNavigate: {_ in})
}
