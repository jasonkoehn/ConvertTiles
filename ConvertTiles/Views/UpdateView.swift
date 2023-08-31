//
//  UpdateView.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 7/21/23.
//

import SwiftUI

struct UpdateView: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var subManager: SubscriptionManager
    @Binding var versionNumber: String
    @Binding var showPaywallView: Bool
    var body: some View {
        VStack(alignment: .center) {
            HStack{Spacer()}
            VStack(alignment: .leading, spacing: 20) {
                Text("Updated to version "+"\(store.appVersionNumber)")
                    .font(.title)
                Group {
                    Text("-Updates for iOS 17.")
                        .font(.title3)
                    Text("-Bug fixes.")
                        .font(.title3)
                    Text("-Added free trial.")
                        .font(.title3)
                }
            }
            
            // One Time Only
            Button(action: {
                showPaywallView.toggle()
                versionNumber = store.appVersionNumber
            }) {
                ZStack {
                    VStack {
                        Text("10 Day Free Trial")
                            .foregroundStyle(.black)
                            .fontDesign(.monospaced)
                        Text("Learn More...")
                            .foregroundStyle(.white)
                            .font(.title2)
                    }
                    .frame(width: 300, height: 55)
                    .background(.blue)
                    .cornerRadius(5)
                }
                .frame(width: 310, height: 65)
                .background(Color.black)
                .cornerRadius(10)
            }
            .padding(.top)
            //
            
            Spacer()
            Button(action: {
                versionNumber = store.appVersionNumber
            }) {
                Text("Dismiss")
                    .foregroundStyle(.foreground)
                    .font(.title2)
                    .frame(width: 230, height: 55)
                    .background(.blue)
                    .clipShape(.rect(cornerRadius: 10))
            }
        }
        .padding(20)
        .background(Color(.systemGray5))
    }
}
