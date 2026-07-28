//
//  GroupSettingsView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 6/7/2026.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case newUser
    case newGuest
    case upgradeGuest(UUID)

    var id: String {
        switch self {
        case .newUser: return "newUser"
        case .newGuest: return "newGuest"
        case .upgradeGuest(let id): return "upgradeGuest-\(id.uuidString)"
        }
    }
}

struct GroupSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appState: AppState
    
    @Binding var group: PokerGroup
    var loadGroup: () -> Void
    
    @State var editingGroupName = false
    @State var newGroupName: String = ""
    
    @State var activeSheet: ActiveSheet? = nil
    
    @State var userErrorMessage = ""
    @State var guestErrorMessage = ""
    
    @State private var groupMembers: [GroupMember] = []
    @State private var guestMembers: [GroupMember] = []
    
    @State var vm = GroupSettingsViewModel()
    
    func turnGuestIntoUser(guestId: UUID) {
        activeSheet = .upgradeGuest(guestId)
    }
    
    @State var groupMemberInitial: [GroupMember] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    GroupNameEditView(
                        editingGroupName: $editingGroupName,
                        newGroupName: $newGroupName,
                        group: $group,
                        vm: $vm,
                        isNotMember: !(appState.getUserRoleInGroup(groupMembers: groupMembers) == .member)
                    )
                    
                    GroupMemberSectionView(
                        groupMembers: $groupMembers,
                        userErrorMessage: $userErrorMessage,
                        activeSheet: $activeSheet,
                        loadGroup: loadGroup
                    )
                    
                    GuestMemberSectionView(
                        guestMembers: $guestMembers,
                        groupMembers: $groupMembers,
                        guestErrorMessage: $guestErrorMessage,
                        activeSheet: $activeSheet,
                        loadGroup: loadGroup,
                        turnGuestIntoUser: turnGuestIntoUser
                    )
                    
                    
                    Spacer()
                }
                .padding(.horizontal,10)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Close") {
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
                                        dismiss()
                                        return
                                    }
                                    let errorMessage = await vm.saveGroupRoles(token: token, groupId: group.id, groupMembers: groupMembers)
                                    print(errorMessage)
                                    loadGroup()
                                }
                            }
                            dismiss()
                        }
                    }
                }
            }
        }.sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .newUser:
                InviteNewUserView(loadGroup: loadGroup)
                    .presentationDetents([.height(300)])
            case .newGuest:
                AddNewGuestUserView(loadGroup: loadGroup)
                    .presentationDetents([.height(300)])
            case .upgradeGuest(let guestId):
                TurnGuestIntoUserView(loadGroup: loadGroup, guestId: guestId)
                    .presentationDetents([.height(300)])
            }
        }
        .onAppear() {
            groupMembers = group.groupMembers.filter { !$0.isGuest }
            guestMembers = group.groupMembers.filter { $0.isGuest }
            
            groupMemberInitial = groupMembers
        }
        .onChange(of: group.groupMembers) {
            groupMembers = group.groupMembers.filter { !$0.isGuest }
            guestMembers = group.groupMembers.filter { $0.isGuest }
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
