//
//  GuestMemberSectionView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 28/7/2026.
//

import SwiftUI

struct GuestMemberSectionView: View {
    
    @EnvironmentObject var appState: AppState
    @Binding var guestMembers: [GroupMember]
    @Binding var groupMembers: [GroupMember]
    @Binding var guestErrorMessage: String
    @Binding var activeSheet: ActiveSheet?
    var loadGroup: () -> Void
    var turnGuestIntoUser: (UUID) -> Void
    @State var editingSettings: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.fill.questionmark")
                Text("Guest Members")
                Spacer()
                
                if (!(appState.getUserRoleInGroup(groupMembers: groupMembers) == .member)) {
                    Button(action: {
                        editingSettings.toggle()
                    }) {
                        Text(editingSettings ? "Save" : "Edit")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            .background(editingSettings ? Color.green : Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
            .font(.title2)
            .fontWeight(.bold)
            
            ForEach($guestMembers, id: \.id) { $groupMember in
                GroupMemberRoleView(groupMember: $groupMember, errorMessage: $guestErrorMessage, userRole: appState.getUserRoleInGroup(groupMembers: groupMembers) ?? .member, loadGroup: loadGroup, turnGuestIntoUser: turnGuestIntoUser, editingSettings: $editingSettings)
                    .padding(.vertical, 2)
            }
            
            
            if !guestErrorMessage.isEmpty {
                HStack {
                    Text(guestErrorMessage)
                        .foregroundColor(.red)
                    Spacer()
                }
            }
            
            if !(appState.getUserRoleInGroup(groupMembers: groupMembers) == .member) {
                HStack {
                    Button(action: {
                        activeSheet = .newGuest
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Guest Member")
                            
                        }
                        .padding(5)
                        .background()
                        .cornerRadius(15)
                        .shadow(radius: 2)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                }
            }
        }
        .padding(10)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.top, 20)
    }
}
struct GuestMemberSectionViewPreview: View {
    @State var groupMembers = [getTestGroupMember(), getTestGroupMember()]
    @State var guestMembers = [getTestGuestMember(), getTestGuestMember()]
    @State var userErrorMessage: String = ""
    @State var activeSheet: ActiveSheet? = .newUser
    func loadGroup() {
        
    }
    func turnGuestIntoUser(_ id: UUID) {
        
    }
    
    
    var body: some View {
        GuestMemberSectionView(
            guestMembers: $guestMembers,
            groupMembers: $groupMembers,
            guestErrorMessage: $userErrorMessage,
            activeSheet: $activeSheet,
            loadGroup: loadGroup,
            turnGuestIntoUser: turnGuestIntoUser
        )
    }
}

#Preview {
    GuestMemberSectionViewPreview()
}
