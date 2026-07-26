//
//  GroupMemberRoleView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 6/7/2026.
//

import SwiftUI

struct GroupMemberRoleView: View {
    @EnvironmentObject var appState: AppState
    @State var groupMember: GroupMember
    @Binding var errorMessage: String
    var userRole: GroupRole
    var loadGroup: () -> Void
    var turnGuestIntoUser: (UUID) -> Void = { _ in }
    
    @State var showingDeleteConfirmation = false
    
    var vm = GroupMemberRoleViewModel()
    
    var body: some View {
        HStack {
            Text(groupMember.name)
            Spacer()
            if !groupMember.isGuest  {
                GroupMemberRolePicker(groupMember: $groupMember, isLeader: userRole == .leader)
            }
            else {
                if userRole != .member {
                    Button(action: {
                        turnGuestIntoUser(groupMember.id)
                    }) {
                        Image(systemName: "envelope")
                    }
                    .buttonStyle(.plain)
                }
            }
            if !(groupMember.role == .leader) && userRole != .member {
                Button(action: {
                    // Delete
                    showingDeleteConfirmation = true
                }) {
                    Image(systemName: "circle.slash")
                }
                .foregroundStyle(Color.red)
            }
        }
        .font(.title2)
        .confirmationDialog("Delete Entry", isPresented: $showingDeleteConfirmation, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                Task {
                    guard let token = try? await appState.validAccessToken() else {
                        errorMessage = "Your session expired. Please log in again."
                        return
                    }
                    errorMessage = await vm.removeGroupMember(token: token, groupId: appState.groupId ?? 0, groupMember: groupMember)
                    loadGroup()
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            let memberType = groupMember.isGuest ? "guest" : "member"
            Text("Are you sure you want to remove this \(memberType) from the group?")
        }
    }
}

struct GroupMemberRoleViewPreview: View {
    @State var error = ""
    
    var body: some View {
        GroupMemberRoleView(groupMember: getTestGroupMember(), errorMessage: $error, userRole: .member, loadGroup: {})
    }
}

#Preview {
    GroupMemberRoleViewPreview()
}
