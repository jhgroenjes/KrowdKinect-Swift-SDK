//
//  SwiftUIView.swift
//  
//
//  Created by Jason Groenjes on 8/25/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var session = WebSocketController()
    @FocusState  var isFocused
    @State var homeAwaySelectionVar : String = "All"
    @State private var seatNumber: String = "1"

    let formatter: NumberFormatter = {
           let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
           return formatter
       }()

    var body: some View {
        ZStack {
            VStack  {
                HStack  {
                    if session.online {
                        Text(".")
                            .padding(.top, 25)
                            .foregroundColor(.green)
                            .font(.system(size:42).bold())
                            .opacity(session.textIsHidden ? 0 : 1)
                    }
                    if !session.online {
                        Text(".")
                            .padding(.top, 25)
                            .foregroundColor(.red)
                            .font(.system(size:42).bold())
                    }
                    // outter button gives user ability to click on the title or the number
                    Button(action: {
                        isFocused = true
                    }) {
                        HStack {
                            Text("Seat")
                                .padding(.top, 47)
                                .foregroundColor(session.viewablecolor)

                            TextField("Seat", text: $seatNumber)
                                .padding(.top, 45)
                                .frame(width: 80)
                                .focused($isFocused)
                                .foregroundColor(session.viewablecolor)
                                .font(.system(size: 23))
                                .keyboardType(.numberPad)
                                .onChange(of: seatNumber) { newValue in
                                    if let number = UInt32(newValue) {
                                        session.deviceID = number
                                    }
                                }
                                .onAppear {
                                    // Ensure seatNumber and session.deviceID are in sync at launch
                                    if session.deviceID == 0 {
                                        session.deviceID = 1
                                        seatNumber = "1"
                                    } else {
                                        seatNumber = String(session.deviceID)
                                    }
                                }
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Button("Clear All") {
                                            seatNumber = ""
                                            session.deviceID = 0 // Resetting to 0 or any default value
                                        }
                                        Spacer() // To push the "Done" button to the right
                                        Button("Done") {
                                            isFocused = false // Dismiss the keyboard
                                            if let number = UInt32(seatNumber.replacingOccurrences(of: ",", with: "")) {
                                            session.deviceID = number
                                            } else {
                                                seatNumber = "1"
                                                session.deviceID = 1
                                            }
                                        }
                                    }
                                } // end .toolbar
                        } // end HStack
                    } // end button action
                    Spacer()
                    Picker("HomeAwayZone", selection: $homeAwaySelectionVar) {
                        ForEach(session.homeAwayChoices, id: \.self) {
                            Text($0)
                                .foregroundColor(session.viewablecolor)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    } // end Picker
                    .foregroundColor(session.viewablecolor)
                    .padding(.top, 47)
                    .frame(width: 110.0)
                    .onChange(of: homeAwaySelectionVar) { newZone in
                        switch newZone {
                            case "All":
                                session.homeAwaySelection = "All"
                            case "Home":
                                session.homeAwaySelection = "Home"
                            case "Away":
                                session.homeAwaySelection = "Away"
                            default:
                                session.homeAwaySelection = "All"
                        }
                    }
                    Text("Zone")
                        .foregroundColor(session.viewablecolor)
                        .padding(.top, 47)
                        .frame(width: 45)
                }
                Spacer()
            }
            .padding(.leading, 10)
            .padding(.trailing, 15)
            VStack {
                Spacer()
                Text(session.displayName)
                    .font(.system(size: 26).bold())
                    .foregroundColor(session.viewablecolor)
                    .opacity(0.7)
                Text(session.displayTagline)
                    .foregroundColor(session.viewablecolor)
                    .opacity(0.7)
                Text("Offine! - try reloading app")
                    .foregroundColor(.red)
                    .font(.system(size: 20).bold())
                    .opacity(session.textIsHidden ? 1 : 0)
                Spacer()
                HStack {
                    Text(session.appVersion)
                        .foregroundColor(session.viewablecolor)
                        .opacity(0.4)
                        .padding()
                }
            } // end VStack for DisplayName section
        } // end Z Stack
        .frame(maxWidth: .infinity)
        //.background(Color.init(UIColor(red: session.red, green: session.green, blue: session.blue, alpha: 1.0))).ignoresSafeArea(.all, edges:.all)
        .background(Color(red: session.red, green: session.green, blue: session.blue)).ignoresSafeArea(.all, edges:.all)
    } // end view
} // end struct

