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
    
    var onUpdate: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            Button(action: {
                showDatePicker = true
            }) {
                HStack {
                    Spacer()
                    Text(formatDate(date: selectedDate))
                        .foregroundColor(.blue)
                        .font(.system(size: 22))
                    Spacer()
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                        .font(.system(size: 20))
                    
                }
                .padding()
                .border(Color.blue, width: 1)
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
    var body: some View {
        DatePickerView(selectedDate: $date)
    }
}

#Preview {
    DatePickerView_Preview()
}
