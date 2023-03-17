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
    @AppStorage("hlb") var hasLaunchedBefore: Bool = false
    @AppStorage("pro") var pro: Bool = false
    @AppStorage("ColorScheme") var colorScheme: String = "system"
    @AppStorage("haveAccentLines") var haveAccentLines: Bool = true
    @State var showAddConverterView: Bool = false
    @State var showSettingsView: Bool = false
    @State var showPaywallView: Bool = false
    @State var accentColor: Color = decodeUDColor(key: "accentColor")
    @State var isEditing: Bool = false
    var body: some View {
        NavigationStack {
            if hasLaunchedBefore {
                ScrollingGridView(accentColor: accentColor, scenePhase: _scenePhase, isEditing: $isEditing, haveAccentLines: $haveAccentLines)
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
                                if pro {
                                    showAddConverterView.toggle()
                                } else {
                                    if store.converters.count < 4 {
                                        showAddConverterView.toggle()
                                    } else {
                                        showPaywallView.toggle()
                                    }
                                }
                            }) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                    .sheet(isPresented: $showAddConverterView) {
                        NavigationStack {
                            AddConverterView(haveAccentLines: haveAccentLines, hasAccentLine: haveAccentLines)
                        }
                    }
                    .sheet(isPresented: $showSettingsView) {
                        NavigationStack {
                            SettingsView(autoColorScheme: _autoColorScheme, haveAccentLines: $haveAccentLines, accentColor: $accentColor)
                        }
                    }
                    .fullScreenCover(isPresented: $showPaywallView) {
                        NavigationStack {
                            PaywallView()
                        }
                    }
            } else {
                LaunchView(hasLaunchedBefore: $hasLaunchedBefore, pro: $pro, showPaywallView: $showPaywallView)
            }
        }
        .preferredColorScheme(colorScheme == "system" ? nil : (colorScheme == "dark" ? .dark : .light))
        .task {
            if await AdaptyManager.shared.getAccessLevel() {
                pro = true
            } else {
                pro = false
            }
        }
        .onChange(of: store.converters) { _ in
            store.saveConverters()
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
