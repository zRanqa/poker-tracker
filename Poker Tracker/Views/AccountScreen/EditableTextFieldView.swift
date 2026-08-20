//
//  EditableTextFieldView.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 20/8/2026.
//

import SwiftUI

struct EditableTextFieldView: View {
    var placeholder: String
    @Binding var text: String
    @State var newText: String = ""
    @State private var editingText: Bool = false
    
    
    @State var initialText: String = ""
    
    var body: some View {
        HStack {
            if editingText {
                TextField(placeholder, text: $newText)
                    .font(.title)
                    .padding(2)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(10)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
            } else {
                Text(text)
                    .font(.title)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            Spacer()
            Button(action: {
                
                let textTrimmed = newText.trimmingCharacters(in: .whitespacesAndNewlines)
                if text == textTrimmed {
                    text = textTrimmed
                    editingText = !editingText
                    return
                }
                if editingText {
                    // Save the new name
                    text = textTrimmed
                    newText = textTrimmed
                }
                else {
                    newText = text
                }
                
                editingText = !editingText
                
            }) {
                Image(systemName: editingText ? "checkmark.circle" : "square.and.pencil")
                    .font(.title)
                    .foregroundStyle(editingText ? .green : .gray)
            }
            .buttonStyle(.plain)
        
        }
        .padding(editingText ? 7 : 10)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.top, 20)
        .onAppear() {
            initialText = text
            
        }
    }
}

struct EditableTextFieldViewPreview: View {
    
    @State var text = "Test initial"
    
    
    var body: some View {
        EditableTextFieldView(placeholder: "Placeholder", text: $text)
    }
}

#Preview {
    EditableTextFieldViewPreview()
}
