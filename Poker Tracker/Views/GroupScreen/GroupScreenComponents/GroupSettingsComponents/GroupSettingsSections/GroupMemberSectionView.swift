//
//  GroupMemberSectionView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 28/7/2026.
//

import SwiftUI

struct GroupMemberSectionView: View {
    @EnvironmentObject var appState: AppState
    @Binding var groupMembers: [GroupMember]
    @Binding var userErrorMessage: String
    @Binding var activeSheet: ActiveSheet?
    var loadGroup: () -> Void
    
    @State var editingSettings: Bool = false
    
    @State var groupMemberInitial: [GroupMember] = []
    @Binding var vm: GroupSettingsViewModel
    @Binding var group: PokerGroup
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.circle")
                Text("Group Members")
                Spacer()
                if (!(appState.getUserRoleInGroup(groupMembers: groupMembers) == .member)) {
                    Button(action: {
                        editingSettings.toggle()
                        
                        if editingSettings == true {
                            groupMemberInitial = groupMembers
                        }
                        else {
                            var rolesChanged = false
                            for i in 0..<groupMemberInitial.count {
                                for j in 0..<groupMembers.count {
                                    if !rolesChanged && groupMembers[i].id == groupMemberInitial[j].id {
                                        rolesChanged = !(groupMembers[i].role == groupMemberInitial[j].role)
                                    }
                                }
                            }
                            
                            if rolesChanged {
                                Task {
                                    guard let token = try? await appState.validAccessToken() else {
                                        return
                                    }
                                    let errorMessage = await vm.saveGroupRoles(token: token, groupId: group.id, groupMembers: groupMembers)
                                    print(errorMessage)
                                    loadGroup()
                                }
                            }
                        }
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
            
            ForEach($groupMembers, id: \.id) { $groupMember in
                GroupMemberRoleView(groupMember: $groupMember,
                                    errorMessage: $userErrorMessage,
                                    userRole: appState.getUserRoleInGroup(groupMembers: groupMembers) ?? .member,
                                    loadGroup: loadGroup,
                                    editingSettings: $editingSettings
                )
                    .padding(.vertical, 2)
            }
            
            if !userErrorMessage.isEmpty {
                HStack {
                    Text(userErrorMessage)
                        .foregroundColor(.red)
                        
                    Spacer()
                }
            }
            
            if !(appState.getUserRoleInGroup(groupMembers: groupMembers) == .member) {
                HStack {
                    Button(action: {
                        activeSheet = .newUser
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add User")
                            
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
        .onAppear() {
            groupMemberInitial = groupMembers
        }
    }
}

struct GroupMemberSectionViewPreview: View {
    @State var groupMembers = [getTestGroupMember(), getTestGroupMember()]
    @State var userErrorMessage: String = ""
    @State var activeSheet: ActiveSheet? = .newUser
    func loadGroup() {
        
    }
    @State var vm = GroupSettingsViewModel()
    @State var group = getTestGroup()
    
    var body: some View {
        GroupMemberSectionView(groupMembers: $groupMembers, userErrorMessage: $userErrorMessage, activeSheet: $activeSheet, loadGroup: loadGroup, vm: $vm, group: $group)
    }
}

#Preview {
    GroupMemberSectionViewPreview()
}
