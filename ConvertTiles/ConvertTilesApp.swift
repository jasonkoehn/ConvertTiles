//
//  ConvertTilesApp.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 2/15/23.
//

import SwiftUI

@main
struct ConvertTilesApp: App {
    @StateObject var store = Store()
    var body: some Scene {
        WindowGroup {
            TrialView()
                .environmentObject(store)
                .onAppear {
                    AdaptyManager.shared.activate()
                }
        }
    }
}


// add update page
// add free trial
// redo paywall page
