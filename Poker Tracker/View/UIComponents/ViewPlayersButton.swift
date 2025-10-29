//
//  DatePicker.swift
//  a1-s4092185-s4008144
//
//  Created by Jonathan Dummett on 30/8/2025.
//

import SwiftUI


struct ViewPlayersButton: View {
    
    var text: String
    var onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
//            Text(name)
//                .font(.subheadline)

            Button(action: {
                onTap()
            }) {
                HStack {
                    Spacer()
                    
                    Text(text)
                        .foregroundColor(.orange)
                        
                    Spacer()
                    
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                .background(Color.black)
                .cornerRadius(8)
//                .background(isValid ? Color.clear : Color(red: 1.0, green: 0.6, blue: 0.6))
            }
        }
    }

}


#Preview {
    ViewPlayersButton(text: "View Players", onTap: {})
}
