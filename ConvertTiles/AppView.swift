//
//  AppView.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 2/15/23.
//

import SwiftUI

struct AppView: View {
    @Environment(\.colorScheme) var autoColorScheme
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var store: Store
    @AppStorage("ColorScheme") var colorScheme: String = "system"
    @State var converters: [Converter] = []
    @State var showAddConverterView: Bool = false
    @State var showSettingsView: Bool = false
    @AppStorage("haveAccentLines") var haveAccentLines: Bool = true
    @State var accentColor: Color = decodeUDColor(key: "accentColor")
    @State var isEditing: Bool = false
    var body: some View {
        NavigationStack {
            ScrollingGridView(converters: $converters, accentColor: accentColor, scenePhase: _scenePhase, isEditing: $isEditing, haveAccentLines: $haveAccentLines)
                .navigationTitle("Converters")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            showSettingsView.toggle()
                        }) {
                            Image(systemName: "gear")
                        }
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            isEditing.toggle()
                        }) {
                            if isEditing {
                                Text("Done")
                                    .font(.system(size: 19))
                            } else {
                                Text("Edit")
                                    .font(.system(size: 19))
                            }
                        }
                        Button(action: {
                            if store.pro {
                                showAddConverterView.toggle()
                            } else {
                                if converters.count < 4 {
                                    showAddConverterView.toggle()
                                } else {
                                    // go to buy sheet
                                }
                            }
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showAddConverterView) {
                    NavigationStack {
                        AddConverterView(converters: $converters, haveAccentLines: haveAccentLines, hasAccentLine: haveAccentLines)
                    }
                }
                .sheet(isPresented: $showSettingsView) {
                    NavigationStack {
                        SettingsView(autoColorScheme: _autoColorScheme, haveAccentLines: $haveAccentLines, accentColor: $accentColor)
                    }
                }
        }
        .preferredColorScheme(colorScheme == "system" ? nil : (colorScheme == "dark" ? .dark : .light))
        .task {
            let manager = FileManager.default
            let decoder = PropertyListDecoder()
            guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
            let convertersUrl = url.appendingPathComponent("converters.plist")
            if let data = try? Data(contentsOf: convertersUrl) {
                if let response = try? decoder.decode([Converter].self, from: data) {
                    converters = response
                }
            }
            if await AdaptyManager.shared.getAccessLevel() {
                store.pro = true
            }
        }
        .onChange(of: converters) { _ in
            saveArray(converters: converters)
        }
    }
}
