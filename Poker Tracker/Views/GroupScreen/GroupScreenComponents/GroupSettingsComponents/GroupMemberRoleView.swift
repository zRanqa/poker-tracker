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
    var isLeader: Bool
    var loadGroup: () -> Void
    var turnGuestIntoUser: (UUID) -> Void = { _ in }
    
    var vm = GroupMemberRoleViewModel()
    
    var body: some View {
        HStack {
            Text(groupMember.name)
            Spacer()
            if !groupMember.isGuest  {
                GroupMemberRolePicker(groupMember: $groupMember, isLeader: isLeader)
            }
            else {
                Button(action: {
                    turnGuestIntoUser(groupMember.id)
                }) {
                    Image(systemName: "envelope")
                }
                .buttonStyle(.plain)
            }
            Button(action: {
                // Delete
                Task {
                    guard let token = try? await appState.validAccessToken() else {
                        errorMessage = "Your session expired. Please log in again."
                        return
                    }
                    errorMessage = await vm.removeGroupMember(token: token, groupId: appState.groupId ?? 0, groupMember: groupMember)
                    loadGroup()
                }
            }) {
                Image(systemName: "circle.slash")
            }
            .foregroundStyle(Color.red)
        }
        .font(.title2)
    }
}

struct GroupMemberRoleViewPreview: View {
    @State var error = ""
    
    var body: some View {
        GroupMemberRoleView(groupMember: getTestGuestMember(), errorMessage: $error, isLeader: true, loadGroup: {})
    }
}

#Preview {
    GroupMemberRoleViewPreview()
}
