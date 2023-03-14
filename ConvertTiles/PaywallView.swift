//
//  PaywallView.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 3/13/23.
//

import SwiftUI
import Adapty

struct PaywallView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: Store
    @State var title: String = "Get ConvertTiles Pro"
    @State var products: [AdaptyPaywallProduct] = []
    var body: some View {
        List {
            ForEach(products, id: \.vendorProductId) { product in
                HStack {
                    VStack(alignment: .leading) {
                        Text(product.localizedTitle)
                            .font(.headline)
                        Text(product.localizedSubscriptionPeriod ?? "")
                            .font(.subheadline)
                        Text(product.localizedDescription)
                        
                    }
                    Spacer()
                    Button(action: {
                        Task {
                            if await AdaptyManager.shared.makePurchase(product: product) {
                                store.pro = true
                            }
                        }
                    }) {
                        Text(product.localizedPrice ?? "Price not available!")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            Button(action: {
                Task {
                    if await AdaptyManager.shared.restorePurchases() {
                        store.pro = true
                    }
                }
            }) {
                Text("Restore Purchase")
            }
            .buttonStyle(.bordered)
        }
        .listStyle(.inset)
        .navigationTitle(title)
        .toolbar {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "multiply")
            }
        }
        .task {
            do {
                guard let paywall = try await Adapty.getPaywall("paywall-1") else {return}

                guard let products = try await Adapty.getPaywallProducts(paywall: paywall) else {return}
                self.products = products
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
