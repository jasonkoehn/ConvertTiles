//
//  UpdateView.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 7/21/23.
//

import SwiftUI

struct UpdateView: View {
    @EnvironmentObject var store: Store
    @Binding var versionNumber: String
    var body: some View {
        Button(action: {
            versionNumber = store.appVersionNumber
        }) {
            Text("OK")
        }
    }
}
