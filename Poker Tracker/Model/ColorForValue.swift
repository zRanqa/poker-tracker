//
//  ColorBlending.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 29/10/2025.
//

import Foundation
import SwiftUI

func colorForValue(value: Double, minValue: Double, maxValue: Double, neutral: Double) -> Color {
    // clamp value
    let clamped = min(max(value, minValue), maxValue)
    
    func lerpColor(from: Color, to: Color, t: Double) -> Color {
        let tClamped = min(max(t, 0), 1)
        // extract components
        let fromComponents = UIColor(from).cgColor.components ?? [0,0,0,1]
        let toComponents = UIColor(to).cgColor.components ?? [0,0,0,1]
        
        let r = fromComponents[0] + (toComponents[0] - fromComponents[0]) * CGFloat(tClamped)
        let g = fromComponents[1] + (toComponents[1] - fromComponents[1]) * CGFloat(tClamped)
        let b = fromComponents[2] + (toComponents[2] - fromComponents[2]) * CGFloat(tClamped)
        
        return Color(red: Double(r), green: Double(g), blue: Double(b))
    }
    
    if clamped >= neutral {
        let ratio = (clamped - neutral) / (maxValue - neutral)
        return lerpColor(from: .white, to: .green, t: ratio)
    } else {
        let ratio = (clamped - minValue) / (neutral - minValue)
        return lerpColor(from: .red, to: .white, t: ratio)
    }
}
