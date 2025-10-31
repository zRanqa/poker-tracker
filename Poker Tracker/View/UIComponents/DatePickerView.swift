//
//  DatePicker.swift
//  a1-s4092185-s4008144
//
//  Created by Jonathan Dummett on 30/8/2025.
//

import SwiftUI

struct DatePickerView: View {
    
    @State private var showDatePicker = false
    @Binding var selectedDate: Date
//    var name: String = "[name]"
    
    var onUpdate: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
//            Text(name)
//                .font(.subheadline)

            Button(action: {
                showDatePicker = true
            }) {
                HStack {
                    Text(formatDateMedium(date: selectedDate))
                        .foregroundColor(.primary)
                        .font(.subheadline)
                    Spacer()
                    Image(systemName: "calendar")
                        .foregroundColor(.orange)
                    
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                .shadow(color: Color.white.opacity(0.8), radius: 4, x: 0, y: 0)
//                .background(isValid ? Color.clear : Color(red: 1.0, green: 0.6, blue: 0.6))
            }
        }
        .sheet(isPresented: $showDatePicker) {
            VStack {
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .padding()

                Button("Done") {
                    showDatePicker = false
                    onUpdate()
                }
                .padding()
            }
            .presentationDetents([.medium])
        }
    }

}

struct DatePickerView_Preview: View {
    @State var date: Date = Date()
//    @State var isValid: Bool = true
    var body: some View {
        DatePickerView(selectedDate: $date)
    }
}

#Preview {
    DatePickerView_Preview()
}
