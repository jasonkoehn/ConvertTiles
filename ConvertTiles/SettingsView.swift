//
//  SettingsView.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 2/15/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("ColorScheme") var colorScheme: String = "system"
    @AppStorage("pro") var pro: Bool = false
    @AppStorage("basicColor") var basicColor: String = "blue"
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
                    .disabled(!pro)
                    .opacity(pro ? 1.0 : 0.5)
                    if !pro {
                            Button(action: {
                                showPaywallView.toggle()
                            }) {
                                Text("Pro")
                                    .font(.system(size: 20))
                                    .foregroundColor(.green)
                            }
                    }
                }
            }
            Section("Tile Accent Color") {
                segmentedColorPicker
                if pro {
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
                        ZStack {
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
            }
            .onChange(of: accentColor) { _ in
                UserDefaults.standard.set(encodeColor(color: accentColor), forKey: "accentColor")
            }
            if !pro {
                Section("Upgrade") {
                    Button(action: {
                        showPaywallView.toggle()
                    }) {
                        Text("Upgrade to Pro")
                            .font(.system(size: 20))
                            .foregroundColor(.green)
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
    
    var segmentedColorPicker: some View {
        Picker("", selection: $basicColor) {
            Text("Red").tag("red")
            Text("Green").tag("green")
            Text("Blue").tag("blue")
            Text("Black").tag("black")
            Text("White").tag("white")
        }
        .pickerStyle(.segmented)
        .onChange(of: basicColor) { color in
            switch color {
            case "red":
                accentColor = .red
            case "green":
                accentColor = .green
            case "blue":
                accentColor = .blue
            case "black":
                accentColor = .black
            case "white":
                accentColor = .white
            default:
                accentColor = .blue
            }
        }
    }
}
