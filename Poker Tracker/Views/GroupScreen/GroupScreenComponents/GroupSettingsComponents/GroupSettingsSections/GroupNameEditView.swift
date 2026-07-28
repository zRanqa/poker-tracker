//
//  GroupNameEditView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 28/7/2026.
//

import SwiftUI

struct GroupNameEditView: View {
    @EnvironmentObject var appState: AppState
    
    @Binding var editingGroupName: Bool
    @Binding var newGroupName: String
    @Binding var group: PokerGroup
    @Binding var vm: GroupSettingsViewModel
    var isNotMember: Bool
    
    @State var initialGroupName: String = ""
    
    let maxLengthChar = 36
    
    var body: some View {
        HStack {
            if editingGroupName && isNotMember {
                TextField("Group Name", text: $newGroupName)
                    .font(.title)
                    .padding(2)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(10)
            } else {
                Text(group.name)
                    .font(.title)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            Spacer()
            if isNotMember {
                Button(action: {
                    var newGroupNameTrimmed = newGroupName.trimmingCharacters(in: .whitespacesAndNewlines)
                    if initialGroupName == newGroupNameTrimmed {
                        newGroupName = newGroupNameTrimmed
                        editingGroupName = !editingGroupName
                        return
                    }
                    if !editingGroupName {
                        newGroupName = group.name
                        initialGroupName = group.name
                        editingGroupName = !editingGroupName
                        return
                    }
                    if newGroupNameTrimmed.count > maxLengthChar {
                        newGroupNameTrimmed = String(newGroupNameTrimmed.prefix(maxLengthChar))
                    }
                    Task {
                        guard let token = try? await appState.validAccessToken() else {
                            return
                        }
                        let status = await vm.updateGroupName(token: token, groupId: appState.groupId ?? 0, name: newGroupNameTrimmed)
                        if status == "success" {
                            group.name = newGroupNameTrimmed
                        }
                    }
                    editingGroupName = !editingGroupName
                    
                }) {
                    Image(systemName: editingGroupName ? "checkmark.circle" : "square.and.pencil")
                        .font(.title)
                        .foregroundStyle(editingGroupName ? .green : .gray)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(editingGroupName ? 7 : 10)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.top, 20)
        .onAppear() {
            initialGroupName = group.name
        }
    }
}

struct GroupNameEditViewPreview: View {
    @State var editingGroupName: Bool = true
    @State var newGroupName: String = "Test"
    @State var group = getTestGroup()
    @State var vm = GroupSettingsViewModel()
    
    var body: some View {
        GroupNameEditView(editingGroupName: $editingGroupName, newGroupName: $newGroupName, group: $group, vm: $vm, isNotMember: false)
    }
}

#Preview {
    GroupNameEditViewPreview()
}
