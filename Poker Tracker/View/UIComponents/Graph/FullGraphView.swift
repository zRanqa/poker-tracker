//
//  FullGraphView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 31/10/2025.
//

import SwiftUI

struct FullGraphView: View {

    var body: some View {
        VStack {
            TotalEarningsChart(fullscreen: true)
        }
        .navigationTitle("Full Graph")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FullGraphView()
}
