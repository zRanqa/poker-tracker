//
//  YearDropdown.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 25/2/2026.
//

import SwiftUI

struct YearDropdown: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var yearOptions: [String]
    @Binding var selectedOption: String
    
    var body: some View {
        Picker("Select an option", selection: $selectedOption) {
            ForEach(yearOptions, id: \.self) {
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
    
    @State var yearOptions = ["2026", "2025", "2024"]
    @State var selectedOption: String = "All"
    
    var body: some View {
        YearDropdown(yearOptions: $yearOptions, selectedOption: $selectedOption)
    }
}

#Preview {
    YearDropdownPreview()
}
