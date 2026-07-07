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
    @EnvironmentObject var appState: AppState
    
    var onNavigate: (AppScreen) -> Void
    
    @State var group: PokerGroup
    
    let lightColor = Color(red: 0.85, green: 0.85, blue: 0.85)
    let darkColor = Color(red: 0.20, green: 0.20, blue: 0.20)
    
    @State var selectedYear: String = "All"
    @State private var selectedTab = 0
    
    @State var showGroupSettingsSheet = false
    
    var vm = GroupScreenViewModel()
    
    func loadGroup() {
        Task {
            if group.id != -1 { // for testing purposes
                group = await vm.getGroupDetails(token: appState.token ?? "", group: group)
            }
            else {
                group.playerTotals = calculateTotals(pokerGroup: group)
            }
        }
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Button(action: {
                    showGroupSettingsSheet = true
                }) {
                    Image(systemName: "gearshape")
                        .font(.system(size: 30, weight: .bold))
                        .padding(.leading, 20)
                }
                .buttonStyle(.plain)
                
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
                    TotalEarningsChart(selectedYear: $selectedYear, playerTotals: $group.playerTotals)
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
                        PlayersTab(playerTotals: $group.playerTotals)
                    }
                    else if selectedTab == GroupTabs.sessions.rawValue  {
                        SessionsTab(groupSessions: $group.pokerSessions)
                    }
                    else if selectedTab == GroupTabs.newNight.rawValue  {
                        NewNightTab(onNavigate: onNavigate, groupId: group.id, groupMembers: group.groupMembers, loadGroup: loadGroup)
                    }
                    
                }
            }
            .task {
                loadGroup()
            }
            Spacer()
            BottomBarView(onNavigate: onNavigate)
        }
        .edgesIgnoringSafeArea(.bottom)
        .fullScreenCover(isPresented: $showGroupSettingsSheet) {
            GroupSettingsView(group: $group, loadGroup: loadGroup)
        }
    }
}

#Preview {
    GroupScreen(onNavigate: {_ in }, group: getTestGroup())
}
