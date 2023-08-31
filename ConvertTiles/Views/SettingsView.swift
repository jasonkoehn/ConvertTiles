//
//  SettingsView.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 2/15/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var subManager: SubscriptionManager
    @AppStorage("ColorScheme") var colorScheme: String = "system"
    @Environment var autoColorScheme: ColorScheme
    @Binding var haveAccentLines: Bool
    @Binding var accentColor: Color
    @State var showPaywallView: Bool = false
    var body: some View {
        List {
            Section("Color Scheme") {
                ZStack {
                    Picker("", selection: $colorScheme) {
                        Text("System").tag("system")
                        Text("Light").tag("light")
                        Text("Dark").tag("dark")
                    }
                    .pickerStyle(.segmented)
                    .disabled(subManager.subStatus == .basic)
                    .opacity(subManager.subStatus == .pro || subManager.subStatus == .trial ? 1.0 : 0.5)
                    if subManager.subStatus == .basic {
                        Button(action: {
                            showPaywallView.toggle()
                        }) {
                            Text("Pro")
                                .foregroundColor(.green)
                                .font(.system(size: 20))
                        }
                    }
                }
            }
            Section("Tile Accent Color") {
                Picker("", selection: $accentColor) {
                    Text("Red").tag(Color.red)
                    Text("Green").tag(Color.green)
                    Text("Blue").tag(Color.blue)
                    Text("Black").tag(Color.black)
                    Text("White").tag(Color.white)
                }
                .pickerStyle(.segmented)
                if subManager.subStatus == .pro || subManager.subStatus == .trial {
                    ColorPicker("Tile Accent Color:", selection: $accentColor)
                    Toggle(isOn: $haveAccentLines) {
                        Text("Tile Accent Lines?")
                    }
                } else {
                    HStack {
                        Text("Tile Accent Color:")
                        Spacer()
                        Button(action: {
                            showPaywallView.toggle()
                        }) {
                            Text("Pro")
                                .foregroundColor(.green)
                                .font(.system(size: 20))
                        }
                    }
                    HStack {
                        Text("Tile Accent Lines?")
                        Spacer()
                        Button(action: {
                            showPaywallView.toggle()
                        }) {
                            Text("Pro")
                                .foregroundColor(.green)
                                .font(.system(size: 20))
                        }
                    }
                }
            }
            .onChange(of: accentColor) { _ in
                UserDefaults.standard.set(encodeColor(color: accentColor), forKey: "accentColor")
            }
            if subManager.subStatus != .pro {
                Section("Upgrade") {
                    Button(action: {
                        showPaywallView.toggle()
                    }) {
                        Text("Upgrade to Pro")
                            .foregroundColor(.green)
                            .font(.system(size: 20))
                    }
                }
            }
        }
        .navigationTitle("Settings")
        .toolbar {
            Button(action: {
                dismiss()
            }) {
                Text("Done")
                    .font(.system(size: 18))
            }
        }
        .preferredColorScheme(colorScheme == "system" ? autoColorScheme : (colorScheme == "dark" ? .dark : .light))
        .fullScreenCover(isPresented: $showPaywallView) {
            NavigationStack {
                PaywallView()
            }
        }
    }
}
