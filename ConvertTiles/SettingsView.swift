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
            Section {
                ColorPicker("Tile Accent Color:", selection: $accentColor)
                    .onChange(of: accentColor) { _ in
                        UserDefaults.standard.set(encodeColor(color: accentColor), forKey: "accentColor")
                    }
                Toggle(isOn: $haveAccentLines) {
                    Text("Tile Accent Lines?")
                }
            }
            Section {
                
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
