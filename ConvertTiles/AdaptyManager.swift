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
                return true
            } else {
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
            try await Adapty.logShowPaywall(paywall)
            let products = try await Adapty.getPaywallProducts(paywall: paywall)
            return products
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
