//
//  SwiftUIView.swift
//
//
//  Created by Jason Groenjes on 8/25/24.
//
// Latest:  0.3.3 (10/6/2024)

import SwiftUI

struct ContentView: View {
    @StateObject var session: WebSocketController
    @State private var isFocused: Bool = false
    @State var homeAwaySelectionVar: String = "All"
    @State private var seatNumber: String = "1"

    init(options: kkOptions) {
        _session = StateObject(wrappedValue: WebSocketController(options: options))
    }

    var body: some View {
        //Background Stack to set color
        ZStack {
            // Background layer
            Color(red: session.red, green: session.green, blue: session.blue)
            .ignoresSafeArea(.all) // Full-screen background

            VStack{
                HStack {
                    // Online status indicator
                    if session.online {
                        Text(".")
                            .foregroundColor(.green)
                            .font(.system(size: 42).bold())
                            .frame(maxWidth: 10, maxHeight: 27, alignment: .bottom)
                            .opacity(session.textIsHidden ? 0 : 1)
                    } else {
                        Text(".")
                            .foregroundColor(.red)
                            .font(.system(size: 42).bold())
                            .frame(maxWidth: 10, maxHeight: 27, alignment: .bottom)
                    }
                    
                    // Seat Number and Zone Selection
                    Button(action: {
                        isFocused = true
                    }) {
                        HStack {
                            Text("Seat")
                                .frame(width: 40)
                                .foregroundColor(session.viewablecolor)
                            FocusableTextField(
                                text: $seatNumber,
                                isFirstResponder: $isFocused,
                                placeholder: "Seat",
                                keyboardType: .numberPad,
                                onClear: {
                                    seatNumber = ""
                                    session.deviceID = 1
                                },
                                onDone: {
                                    DispatchQueue.main.async {
                                           isFocused = false
                                       }
                                    if let number = UInt32(seatNumber.replacingOccurrences(of: ",", with: "")) {
                                        session.deviceID = number
                                        if number == 0 {session.deviceID = 1}
                                    } else {
                                        seatNumber = "1"
                                        session.deviceID = 1
                                    }
                                },
                                textColor: UIColor(session.viewablecolor),
                                font: UIFont.systemFont(ofSize: 23)
                            )
                            .frame(width: 80, height: 40, alignment: .top)
                            .foregroundColor(session.viewablecolor)
                            
                        }
                    }
                    
                    Spacer()
                    
                    // Zone Selection Picker
                    Picker("HomeAwayZone", selection: $homeAwaySelectionVar) {
                        ForEach(session.homeAwayChoices, id: \.self) {
                            Text($0)
                                .foregroundColor(session.viewablecolor)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .foregroundColor(session.viewablecolor)
                    .onChange(of: homeAwaySelectionVar) { newZone in
                        session.homeAwaySelection = newZone
                    }
                    
                    Text("Zone")
                        .foregroundColor(session.viewablecolor)
                }
                .padding([.leading, .trailing, .top], 15)
                
                Spacer() // Pushes the middle content to the center
                
                // Middle Row
                VStack {
                    Text(session.displayName)
                        .font(.system(size: 26).bold())
                        .foregroundColor(session.viewablecolor)
                        .opacity(0.7)
                    Text(session.displayTagline)
                        .foregroundColor(session.viewablecolor)
                        .opacity(0.7)
                //    if !session.online {
                //        Text("Offline! - try reloading")
                //            .foregroundColor(.red)
                //            .font(.system(size: 20).bold())
                //    }
                } // end VStack Middle section
                
                Spacer() // Pushes the bottom content to the bottom
                
                // Bottom Row
                HStack {
                    Spacer()
                    Text(session.appVersion)
                        .foregroundColor(session.viewablecolor)
                        .opacity(0.4)
                        .padding()
                    Spacer()
                }
            }
        } // end ZStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    } // end Body View    
} // end struct



