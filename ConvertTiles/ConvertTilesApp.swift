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
    @StateObject var subscriptionManager = SubscriptionManager()
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(store)
                .environmentObject(subscriptionManager)
        }
    }
}
