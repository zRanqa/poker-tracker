//
//  GroupSettingsView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 6/7/2026.
//

import SwiftUI

struct GroupSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appState: AppState
    
    @Binding var group: PokerGroup
    var loadGroup: () -> Void
    
    @State var editingGroupName = false
    @State var newGroupName: String = ""
    
    @State var showNewUserForm = false
    @State var showNewGuestForm = false
    
    var groupMembers: [GroupMember] {
        group.groupMembers.filter{ $0.isGuest == false }
    }
    var guestMembers: [GroupMember] {
        group.groupMembers.filter{ $0.isGuest == true }
    }
    
    var vm = GroupSettingsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack() {
                    HStack {
                        if editingGroupName {
                            TextField("Group Name", text: $newGroupName)
                                .font(.title)
                                .padding(2)
                                .background(.gray.opacity(0.2))
                                .cornerRadius(10)
                        } else {
                            Text(group.name)
                                .font(.title)
                        }
                        Spacer()
                        Button(action: {
                            if editingGroupName {
                                Task {
                                    let status = await vm.updateGroupName(token: appState.token ?? "", groupId: appState.groupId ?? 0, name: newGroupName)
                                    if status == "success" {
                                        group.name = newGroupName
                                    }
                                }
                            }
                            else {
                                newGroupName = group.name
                            }
                            editingGroupName = !editingGroupName
                            
                        }) {
                            Image(systemName: editingGroupName ? "checkmark.circle" : "square.and.pencil")
                                .font(.title)
                                .foregroundStyle(editingGroupName ? .green : .gray)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(editingGroupName ? 7 : 10)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.top, 20)
                    
                    VStack {
                        HStack {
                            Image(systemName: "person.circle")
                            Text("Group Members")
                            Spacer()
                        }
                        .font(.title2)
                        .fontWeight(.bold)
                        
                        ForEach(groupMembers, id:\.id) { groupMember in
                            GroupMemberRoleView(groupMember: groupMember, isLeader: true)
                                .padding(.vertical, 2)
                        }
                        
                        HStack {
                            Button(action: {
                                showNewUserForm = true
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
                    .padding(10)
                    .background(Color(.secondarySystemBackground))
            
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.top, 20)
                    
                    VStack {
                        HStack {
                            Image(systemName: "person.fill.questionmark")
                            Text("Guest Members")
                            Spacer()
                        }
                        .font(.title2)
                        .fontWeight(.bold)
                        
                        ForEach(guestMembers, id:\.id) { groupMember in
                            GroupMemberRoleView(groupMember: groupMember, isLeader: true)
                                .padding(.vertical, 2)
                        }
                        
                        HStack {
                            Button(action: {
                                showNewGuestForm = true
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
                    .padding(10)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.top, 20)
                    
                    
                    Spacer()
                }
                .padding(.horizontal,10)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Close") {
                            dismiss()
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showNewUserForm) {
            InviteNewUserView(loadGroup: loadGroup)
                .presentationDetents([.height(300)])
        }
        .sheet(isPresented: $showNewGuestForm) {
            AddNewGuestUserView(loadGroup: loadGroup)
                .presentationDetents([.height(300)])
        }
    }
}

struct GroupSettingsViewPreview: View {
    @State var group = getTestGroup()
    var body: some View {
        
        GroupSettingsView(group: $group, loadGroup: {})
    }
}

#Preview {
    GroupSettingsViewPreview()
}
