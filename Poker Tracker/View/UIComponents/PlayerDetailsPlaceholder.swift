//
//  DatePicker.swift
//  a1-s4092185-s4008144
//
//  Created by Jonathan Dummett on 30/8/2025.
//

import SwiftUI


struct PlayerDetailsPlaceholder: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
//            Text(name)
//                .font(.subheadline)

            HStack {
                HStack(spacing: 0) {
                    Text("")
                        .frame(width: CGFloat(Int.random(in: 60...80)), alignment: .leading)
                        .padding(.horizontal, 8)
                        .background(.orange)
                    Spacer()
                }
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
        
        }
    }

}


#Preview {
    PlayerDetailsPlaceholder()
}
