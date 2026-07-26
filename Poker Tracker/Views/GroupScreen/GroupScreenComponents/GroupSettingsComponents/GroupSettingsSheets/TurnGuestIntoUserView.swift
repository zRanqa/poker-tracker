//
//  InviteNewUserView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 7/7/2026.
//

import SwiftUI

struct TurnGuestIntoUserView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appState: AppState
    
    var loadGroup: () -> Void
    var guestId: UUID
    
    @State var newUser: String = ""
    @State var errorMessage = ""
    
    var vm = TurnGuestIntoUserViewViewModel()
    
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
                            
                            guard let token = try? await appState.validAccessToken() else {
                                errorMessage = "Your session expired. Please log in again."
                                return
                            }
                            errorMessage = await vm.turnGuestIntoUser(token: token, groupId: appState.groupId ?? 0, guestId: guestId, userEmail: newUser)
                            if errorMessage == "" {
                                loadGroup()
                                dismiss()
                            }
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
    TurnGuestIntoUserView(loadGroup: {}, guestId: UUID())
}
