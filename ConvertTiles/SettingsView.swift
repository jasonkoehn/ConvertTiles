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
    @Binding var pro: Bool
    @AppStorage("basicColor") var basicColor: String = "blue"
    @Environment var autoColorScheme: ColorScheme
    @Binding var haveAccentLines: Bool
    @Binding var accentColor: Color
    var body: some View {
        List {
            Section("Color Scheme") {
                Picker("", selection: $colorScheme) {
                    Text("System").tag("system")
                    Text("Light").tag("light")
                    Text("Dark").tag("dark")
                }
                .pickerStyle(.segmented)
            }
            Section("Tile Accent Color") {
                if pro {
                    ColorPicker("Tile Accent Color:", selection: $accentColor)
                    Toggle(isOn: $haveAccentLines) {
                        Text("Tile Accent Lines?")
                    }
                } else {
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
            .onChange(of: accentColor) { _ in
                UserDefaults.standard.set(encodeColor(color: accentColor), forKey: "accentColor")
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
    }
}
