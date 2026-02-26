//
//  GroupScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 25/2/2026.
//

import SwiftUI

struct GroupScreen: View {
    @Environment(\.colorScheme) var colorScheme
    
    var onNavigate: (AppScreen) -> Void
    
    var group: PokerGroup
    
    let lightColor = Color(red: 0.85, green: 0.85, blue: 0.85)
    let darkColor = Color(red: 0.20, green: 0.20, blue: 0.20)
    
    @State var selectedYear: String = "All"
    @State var selectedTab: String = "Overview"
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 30, weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
                
                Text(group.name)
                    .font(.title)
                
                Spacer()
                
                YearDropdown(yearOptions: ["2026", "2025", "2024"], selectedOption: $selectedYear)
                    .padding(.trailing, 20)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 10)
            .background(colorScheme == .dark ? darkColor : lightColor)
            
            
            ScrollView {
                TotalEarningsChart(selectedYear: $selectedYear)
                    .padding(.bottom, 10)
                
                HStack {
                    Spacer()
                    TabButton(selectedTab: $selectedTab, tabTitle: "Overview")
                    Spacer()
                    TabButton(selectedTab: $selectedTab, tabTitle: "Players")
                    Spacer()
                    TabButton(selectedTab: $selectedTab, tabTitle: "Sessions")
                    Spacer()
                    TabButton(selectedTab: $selectedTab, tabTitle: "New Night")
                    Spacer()
                }
                
                if selectedTab == "Overview" {
                    OverviewTab(onNavigate: onNavigate)
                }
                else if selectedTab == "Players" {
                    PlayersTab()
                }
                else if selectedTab == "Sessions" {
                    SessionsTab()
                }
                else if selectedTab == "New Night" {
                    NewNightTab()
                }
                
                Spacer()
                
            }
        }
    }
}

#Preview {
    GroupScreen(onNavigate: {_ in }, group: PokerGroup(id: "1", name: "Test Group", color: Color(red: 0.5, green: 0.5, blue: 0.5)))
}
