//
//  GroupMemberRolePicker.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 6/7/2026.
//

import SwiftUI

struct GroupMemberRolePicker: View {
    
    @Binding var groupMember: GroupMember
    var isLeader: Bool
    private let roles = ["moderator", "member"]
    
    private func icon(for role: String?) -> String {
        switch role {
        case "leader":
            return "crown.fill"
        case "moderator":
            return "shield.fill"
        case "member":
            return "person.fill"
        default:
            return "questionmark.app"
        }
    }
    
        
    var body: some View {
        if groupMember.role == "leader" {
            Image(systemName: icon(for: groupMember.role))
        }
        else {
            Menu {
                ForEach(roles, id: \.self) { role in
                    Button {
                        groupMember.role = role
                    } label: {
                        Label(role.capitalized, systemImage: icon(for: role))
                    }
                }
            } label: {
                HStack {
                    Image(systemName: icon(for: groupMember.role))
                    
                    if isLeader && groupMember.role != "leader" {
                        Image(systemName: "chevron.down")
                    }
                }
            }
            .disabled(!isLeader)
            .buttonStyle(.plain)
        }
    }
}

struct GroupMemberRolePickerPreview: View {
    @State var groupMember = getTestGroupMember()
    var body: some View {
        GroupMemberRolePicker(groupMember: $groupMember, isLeader: true)
    }
}

#Preview {
    GroupMemberRolePickerPreview()
}
