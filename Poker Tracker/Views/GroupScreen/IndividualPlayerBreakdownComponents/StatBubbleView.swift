//
//  StatBubbleView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 17/8/2026.
//

import SwiftUI

struct StatBubbleView: View {
    
    var title: String
    var value: String
    var valueFont: Font
    
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(valueFont)
            Text(title)
                .font(.caption)
        }
        
//        .padding(20)
        .frame(width: width, height: height)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous).stroke(.white.opacity(0.25), lineWidth: 1)
        }
        .shadow(radius: 12)
    }
}

#Preview {
    StatBubbleView(
        title: "Win Percentage",
        value: "30.0%",
        valueFont: .title,
        width: 200,
        height: 100
    )
}
