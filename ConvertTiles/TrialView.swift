//
//  TrialView.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 7/24/23.
//

import SwiftUI

struct TrialView: View {
    @EnvironmentObject var freeTrialManager: FreeTrialManager
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                freeTrialManager.getFreeTrial()
            }) {
                Text("Save")
                    .font(.body)
            }
            Spacer()
            Button(action: {
                Task {
                    await KeychainManager().delete(key: "freeTrialKey212121")
                }
            }) {
                Text("Delete")
                    .font(.body)
            }
            Spacer()
            Button(action: {
                freeTrialManager.checkFreeTrial()
                print(freeTrialManager.freeTrialStatus)
            }) {
                Text("Get")
                    .font(.body)
            }
            Spacer()
        }
    }
}
