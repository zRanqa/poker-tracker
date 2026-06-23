//
//  YearDropdown.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 25/2/2026.
//

import SwiftUI

struct YearDropdown: View {
    @Environment(\.colorScheme) var colorScheme
    
    var yearOptions: [String]
    var options: [String] {
        ["All"] + yearOptions
    }
    
    @Binding var selectedOption: String
    
    var body: some View {
        Picker("Select an option", selection: $selectedOption) {
            ForEach(options, id: \.self) {
                Text($0)
            }
        }
        
        .pickerStyle(.menu)
        .background(.ultraThinMaterial)
        .tint(.primary)
        
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            Capsule()
                .stroke(Color(.separator), lineWidth: 1)
        )
        
    }
    
}

struct YearDropdownPreview: View {
    
    @State var selectedOption: String = "All"
    
    var body: some View {
        YearDropdown(yearOptions: ["2026", "2025", "2024"], selectedOption: $selectedOption)
    }
}

#Preview {
    YearDropdownPreview()
}
