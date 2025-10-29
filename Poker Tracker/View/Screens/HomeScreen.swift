//
//  AddNightScreen.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/10/2025.
//

import SwiftUI
import SwiftData

struct HomeScreen: View {
    
    var onNavigate: (AppScreen) -> Void
    
    /// Testing
    @State var test: String = ""
    @State var testbool: Bool = false
    @State var color: Color = .blue
    @State private var offset = CGSize.zero
    @State private var showBox = false
    /// Testing end
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("Home")
                    .font(.title)
                    .padding(.bottom)
                
                /// Testing
//                Grid {
//                    GridRow {
//                        Text("A1"); Text("B1"); Text("C1")
//                    }
//                    GridRow {
//                        Text("A2"); Text("B2"); Text("C2")
//                    }
//                }
//                
//                List {
//                    Text("Apple")
//                    Text("Banana")
//                    Text("Cherry")
//                }
//                
//                Form {
//                   Section(header: Text("Profile")) {
//                       TextField("Username", text: $test)
//                       TextField("Password", text: $test)
//                   }
//
//                   Section(header: Text("Preferences")) {
//                       Toggle("Enable Notifications", isOn: $testbool)
//                   }
//
//                   Section {
//                       Button("Save Settings") {
//                           print("Saved")
//                       }
//                   }
//               }
//                
//                Circle()
//                    .fill(color)
//                    .frame(width: 100, height: 100)
//                    .onTapGesture {
//                        color = .green
//                    }
//                    .onLongPressGesture {
//                        color = .red
//                    }
//                    .offset(offset)
//                    .gesture(
//                        DragGesture()
//                            .onChanged { gesture in
//                                offset = gesture.translation
//                            }
//                            .onEnded { _ in
//                                withAnimation {
//                                    offset = .zero
//                                }
//                            }
//                    )
//                
//                VStack {
//                    Button("Toggle Box") {
//                        withAnimation {
//                            showBox.toggle()
//                        }
//                    }
//
//                    if showBox {
//                        Rectangle()
//                            .fill(Color.purple)
//                            .frame(width: 150, height: 150)
//                            .transition(.slide)
//                    }
//                }
                
                /// Testing end
            
                Spacer()
                
                
                BottomBar(onNavigate: onNavigate)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    HomeScreen(onNavigate: { _ in })
}
