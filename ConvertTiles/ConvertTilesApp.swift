//
//  ConvertTilesApp.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 2/15/23.
//

import SwiftUI

@main
struct ConvertTilesApp: App {
    @AppStorage("ColorScheme") var colorScheme: String = "system"
    var body: some Scene {
        WindowGroup {
            AppView()
                .preferredColorScheme(colorScheme == "system" ? nil : (colorScheme == "dark" ? .dark : .light))
        }
    }
}
