//
//  DatePicker.swift
//  a1-s4092185-s4008144
//
//  Created by Jonathan Dummett on 30/8/2025.
//

import SwiftUI


struct PlayerDetailsView: View {
    
    var playerDetails: PlayerDetails
        
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
//            Text(name)
//                .font(.subheadline)

            HStack {
                HStack(spacing: 0) {
                    Text(playerDetails.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 8)
                        .foregroundStyle(.orange)
                    
                    
//                    Divider()
//                        .frame(height: 20)
//                        .background(Color.white.opacity(0.8))
//                    
//                    Text(formatAmount(amount: playerEntry.startingAmount))
//                        .frame(width: 70, alignment: .trailing)
//                        .padding(.horizontal, 8)
//                        .foregroundStyle(.white)
//                    
//                    Divider()
//                        .frame(height: 20)
//                        .background(Color.white.opacity(0.8))
//                    
//                    Text(formatAmount(amount: playerEntry.endingAmount))
//                        .frame(width: 70, alignment: .trailing)
//                        .padding(.horizontal, 8)
//                        .foregroundStyle(getEndColor())
                }
                
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
        
        }
    }

}


#Preview {
    PlayerDetailsView(playerDetails: getTestPlayerDetails())
}
