//
//  TabButton.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 26/2/2026.
//

import SwiftUI

struct TabButton: View {
    
    @Binding var selectedTab: String
    var tabTitle: String
    
    var body: some View {
        Button(action: {
            selectedTab = tabTitle
        }) {
            VStack {
                Text(tabTitle)
                    .tint(selectedTab == tabTitle ? Color.blue : Color.primary)
                
                if selectedTab == tabTitle {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 70, height: 1)
                        .padding(.horizontal, 10)
                }
            }
        }
    }
}

struct TabButtonPreview: View {
    @State var selectedTab: String = "Overview"
    
    var body: some View {
        TabButton(selectedTab: $selectedTab, tabTitle: "Overview")
    }
}

#Preview {
    TabButtonPreview()
}
