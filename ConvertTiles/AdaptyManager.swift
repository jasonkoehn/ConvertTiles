//
//  AdaptyManager.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 3/13/23.
//

import Foundation
import Adapty

class AdaptyManager {
    static let shared = AdaptyManager()
    
    let accessLevelKey = "Pro"
    
    func activate() {
        Adapty.activate("public_live_d1ONpsQI.T8x9giuF3wnR0oLfTilN")
    }
    
    func getAccessLevel() async -> Bool {
        do {
            let profileInfo = try await Adapty.getProfile()
            if profileInfo?.accessLevels[accessLevelKey]?.isActive == true {
                print("has premium")
                return true
            } else {
                print("has basic")
                return false
            }
        } catch {
            print("🤬"+error.localizedDescription)
            return false
        }
    }
    
    func makePurchase(product: AdaptyPaywallProduct) async -> Bool {
        do {
            let purchaseResult = try await Adapty.makePurchase(product: product)
            if purchaseResult.accessLevels[accessLevelKey]?.isActive == true {
                return true
            } else {
                return false
            }
        } catch {
            print("🤬"+error.localizedDescription)
            return false
        }
    }
    
    func restorePurchases() async -> Bool {
        do {
            let restoreResult = try await Adapty.restorePurchases()
            if restoreResult.accessLevels[accessLevelKey]?.isActive == true {
                return true
            } else {
                return false
            }
        } catch {
            print("🤬"+error.localizedDescription)
            return false
        }
    }
    
    func getProducts() async -> [AdaptyPaywallProduct]? {
        do {
            guard let paywall = try await Adapty.getPaywall("paywall-1") else {return []}
            
            let products = try await Adapty.getPaywallProducts(paywall: paywall)
            return products
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}

//struct PaywallView: View {
//    @Environment(\.dismiss) var dismiss
//    @AppStorage("pro") var pro: Bool = false
//    @State var products: [AdaptyPaywallProduct] = []
//    @State var hasLoaded: Bool = false
//    var body: some View {
//        ZStack {
//            if !hasLoaded {
//                ProgressView()
//            } else {
//                paywallPage
//            }
//        }
//        .navigationTitle("Get ConvertTiles Pro")
//        .toolbar {
//            Button(action: {
//                dismiss()
//            }) {
//                Image(systemName: "multiply")
//            }
//        }
//        .task {
//            if let products = await AdaptyManager.shared.getProducts() {
//                self.products = products
//                hasLoaded = true
//            }
//        }
//    }
//
//    var paywallPage: some View {
//        List {
//            ForEach(products, id: \.vendorProductId) { product in
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text(product.localizedTitle)
//                            .font(.headline)
//                        Text(product.localizedSubscriptionPeriod ?? "")
//                            .font(.subheadline)
//                        Text(product.localizedDescription)
//
//                    }
//                    Spacer()
//                    Button(action: {
//                        Task {
//                            if await AdaptyManager.shared.makePurchase(product: product) {
//                                pro = true
//                            }
//                        }
//                    }) {
//                        Text(product.localizedPrice ?? "Price not available!")
//                    }
//                    .buttonStyle(.borderedProminent)
//                }
//            }
//            Button(action: {
//                Task {
//                    if await AdaptyManager.shared.restorePurchases() {
//                        pro = true
//                    }
//                }
//            }) {
//                Text("Restore Purchase")
//            }
//            .buttonStyle(.bordered)
//        }
//        .listStyle(.inset)
//    }
//}
