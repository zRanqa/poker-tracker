//
//  CreateGroupFormView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 30/7/2026.
//

import SwiftUI

struct CreateGroupFormView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) private var dismiss
    
    private let lightBackground: Color = Color(red: 0.9, green: 0.9, blue: 0.9)
    private let darkBackground: Color = Color(red: 0.1, green: 0.1, blue: 0.1)
    
    private let lightText: Color = Color(red: 0.7, green: 0.7, blue: 0.7)
    private let darkText: Color = Color(red: 0.4, green: 0.4, blue: 0.4)
    
    var vm = CreateGroupFormViewModel()
    @State private var selectedColor: Color = .blue
    
    @State var groupName: String = ""
    @State var errorMessage: String = ""
    
    var loadGroups: () -> Void
    
    private func createGroup() {
        if groupName == "" {
            errorMessage = "Please enter a group name"
            return
        }
        let newGroupNameTrimmed = groupName.trimmingCharacters(in: .whitespacesAndNewlines)

        if newGroupNameTrimmed.count > 36 {
            errorMessage = "Group name must be less than 36 characters"
            return
        }
        
        Task {
            guard let token = try? await appState.validAccessToken() else {
                return
            }
            errorMessage = await vm.createGroup(token: token, name: newGroupNameTrimmed, color: selectedColor)
            if errorMessage == "" {
                dismiss()
                loadGroups()
            }
        }
        
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("New Group")
                    .font(.title)
                    .padding(.bottom, 30)
                
                
                HStack {
                    Text("Group Name:")
                        .font(.title3)
                    Spacer()
                }
                TextField("Group Name", text: $groupName)
                    .font(.subheadline)
                    .tint(.orange)
                    .foregroundStyle(.primary)
                
                    .frame(maxWidth: .infinity)
                    .padding(15)
                    .background(colorScheme == .light ? lightBackground : darkBackground)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(colorScheme == .light ? lightText : darkText, lineWidth: 2)
                    )
                    .autocorrectionDisabled(true)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 5)
                
                
                HStack {
                    Text("Color:")
                        .font(.title3)
                    Spacer()
                }
                
                HStack {
                    Circle()
                        .fill(selectedColor)
                        .frame(width: 100, height: 100)
                        .shadow(radius: 5)
                    
                    ColorPicker("Choose a color", selection: $selectedColor)
                        .padding()
                        .font(.title2)
                }
                .padding(.bottom, 20)
                
                
                if errorMessage.isEmpty == false {
                    Text(errorMessage)
                        .font(.body)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 5)
                }
                
                
                Button(action: {
                    createGroup()
                }) {
                    Text("Create Group")
                        .foregroundColor(.primary)
                        .fontWeight(.semibold)
                        .frame(height: 20)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(Color.orange)
                        .cornerRadius(8)
                    //            .shadow(color: Color.white.opacity(0.8), radius: 4, x: 0, y: 0)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    CreateGroupFormView(loadGroups: {})
}
