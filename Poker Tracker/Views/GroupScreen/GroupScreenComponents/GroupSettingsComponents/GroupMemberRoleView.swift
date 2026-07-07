//
//  GroupMemberRoleView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 6/7/2026.
//

import SwiftUI

struct GroupMemberRoleView: View {
    @State var groupMember: GroupMember
    var isLeader: Bool
    var body: some View {
        HStack {
            Text(groupMember.name)
            Spacer()
            if !groupMember.isGuest  {
                GroupMemberRolePicker(groupMember: $groupMember, isLeader: isLeader)
            }
            Button(action: {
                // Delete
            }) {
                Image(systemName: "circle.slash")
            }
            .foregroundStyle(Color.red)
        }
        .font(.title2)
    }
}

#Preview {
    GroupMemberRoleView(groupMember: getRandomGroupMember(), isLeader: true)
}
