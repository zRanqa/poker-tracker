//
//  InviteNewUserView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 7/7/2026.
//

import SwiftUI

struct InviteNewUserView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appState: AppState
    
    var loadGroup: () -> Void
    
    @State var newUser: String = ""
    @State var errorMessage = ""
    
    var vm = InviteNewUserViewViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Email:")
                    Spacer()
                }
                .padding(.top, 20)
                TextField("Enter an Email", text: $newUser)
                    .padding(10)
                    .background()
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                
                VStack {
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                    Button(action: {
                        Task {
                            errorMessage = await vm.addUser(token: appState.token ?? "", groupId: appState.groupId ?? 0, email: newUser)
                        }
                    }) {
                        Text("Invite")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.green)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.green.opacity(0.4), lineWidth: 0.5)
                            )
                    }
                }
                .padding(.top, 20)
                Spacer()
            }
            .font(.title2)
            .padding(.horizontal)
            .background(Color(.secondarySystemBackground))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}


#Preview {
    InviteNewUserView(loadGroup: {})
}
