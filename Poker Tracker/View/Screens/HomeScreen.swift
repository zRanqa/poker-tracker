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
    
    @State var showFullscreenGraph: Bool = false
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Home")
                        .font(.title)
                        .padding(.bottom, 10)
                    
                    HStack {
                        Text("All Time Earnings:")
                            .font(.system(size: 25))
                            .foregroundStyle(.orange)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, -15)
                    
                    TotalEarningsChart()
                    
                    Button(action: {
                        showFullscreenGraph = true
                    }) {
                        Text("View Full Graph")
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .foregroundStyle(.orange)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray)
                            )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 25)

                    ShowOtherStats()
                        .padding(.bottom, 5)
                    
                }
            }
            
            Spacer()
            
            BottomBar(onNavigate: onNavigate)
        }
        .fullScreenCover(isPresented: $showFullscreenGraph) {
            VStack {
                FullGraphView(showFullscreenGraph: $showFullscreenGraph)
            }
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
