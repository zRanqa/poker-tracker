//
//  AddNightScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/10/2025.
//

import SwiftUI
import SwiftData

struct HomeScreen: View {
    
    var onNavigate: (AppScreen) -> Void
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("Home")
                    .font(.title)
                    .padding(.bottom)
                
                Spacer()
                
                BottomBar(onNavigate: onNavigate)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    HomeScreen(onNavigate: { _ in })
}
