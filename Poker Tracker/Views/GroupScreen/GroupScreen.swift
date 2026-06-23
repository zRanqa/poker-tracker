//
//  GroupScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 25/2/2026.
//

enum GroupTabs: Int {
    case overview = 0
    case players = 1
    case sessions = 2
    case newNight = 3
}

import SwiftUI

struct GroupScreen: View {
    @Environment(\.colorScheme) var colorScheme
    
    var onNavigate: (AppScreen) -> Void
    
    var group: PokerGroup
    
    let lightColor = Color(red: 0.85, green: 0.85, blue: 0.85)
    let darkColor = Color(red: 0.20, green: 0.20, blue: 0.20)
    
    @State var selectedYear: String = "All"
    
    @State private var selectedTab = 0
    
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
                VStack {
                    TotalEarningsChart(selectedYear: $selectedYear)
                        .padding(.bottom, 10)
                    
                        
                    Picker("", selection: $selectedTab) {
                        Text("Overview").tag(0)
                        Text("Players").tag(1)
                        Text("Sessions").tag(2)
                        Text("New Night").tag(3)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    
                    if selectedTab == GroupTabs.overview.rawValue {
                        OverviewTab(onNavigate: onNavigate)
                    }
                    else if selectedTab == GroupTabs.players.rawValue {
                        PlayersTab()
                    }
                    else if selectedTab == GroupTabs.sessions.rawValue  {
                        SessionsTab()
                    }
                    else if selectedTab == GroupTabs.newNight.rawValue  {
                        NewNightTab(onNavigate: onNavigate)
                    }
                    
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    GroupScreen(onNavigate: {_ in }, group: PokerGroup(id: "1", name: "Test Group", color: Color(red: 0.5, green: 0.5, blue: 0.5)))
}
