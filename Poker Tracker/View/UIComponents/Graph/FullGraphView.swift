//
//  FullGraphView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 31/10/2025.
//

import SwiftUI

struct FullGraphView: View {
    
    @Binding var showFullscreenGraph: Bool

    var body: some View {
        VStack {
            
            TotalEarningsChart(fullscreen: true, onTap: { showFullscreenGraph = false })
        
        }
        .navigationTitle("Full Graph")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FullGraphViewPreview: View {
    
    @State var test = false
    
    var body: some View {
        
        FullGraphView(showFullscreenGraph: $test)
    }
}

#Preview {
    FullGraphViewPreview()
}
