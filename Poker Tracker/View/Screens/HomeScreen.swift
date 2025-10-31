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
    
    @State var playerTotals: [PlayerTotals] = []
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Home")
                        .font(.title)
                        .padding(.bottom)
                    
                    TotalEarningsChart()
                    
//                    ForEach (orderPlayerTotals(), id: \.playerDetails.id) { playerTotal in
//                        HStack {
//                        
//                            Text(playerTotal.playerDetails.name)
//                            Spacer()
//                            Text("\(formatAmount(amount: playerTotal.totalMoney))")
//                        }
//                        .padding(.horizontal, 20)
//                    }
                    
                    
                    
                }
            }
            
            Spacer()
            
            BottomBar(onNavigate: onNavigate)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear() {
            Task {
                playerTotals = await calculateTotals()
            }
        }
    }
        
    private func orderPlayerTotals() -> [PlayerTotals] {
        return playerTotals.sorted { $0.totalMoney > $1.totalMoney }
    }
}

#Preview {
    HomeScreen(onNavigate: { _ in })
}
