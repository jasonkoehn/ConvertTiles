//
//  SubscriptionManager.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 8/29/23.
//

import SwiftUI
import Adapty

enum SubscriptionStatus {
    case basic
    case trial
    case pro
}

class SubscriptionManager: ObservableObject {
    @ObservedObject var freeTrialManager = FreeTrialManager()
    @Published var subStatus: SubscriptionStatus = .basic
    @Published var trialStatus: FreeTrialStatus = .unused
    @Published var daysLeft: Int = 0
    var pro: Bool = false
    
    init() {
        Task {
            AdaptyManager.shared.activate()
            pro = UserDefaults.standard.bool(forKey: "pro")
            await getSubStatus()
        }
    }
    // Check Subscription Status
    func initSubStatus() async {
        // Check if pro has been purchased
        if await AdaptyManager.shared.getAccessLevel() {
            pro = true
        }
        UserDefaults.standard.set(pro, forKey: "pro")
        // Check free trial status
        let freeTrialInfo = await freeTrialManager.checkFreeTrial()
        daysLeft = freeTrialInfo.daysLeft
        let freeTrialStatus = freeTrialInfo.freeTrialStatus
        if pro {
            subStatus = .pro
        } else {
            switch freeTrialStatus {
            case .unused:
                subStatus = .basic
                trialStatus = .unused
            case .inUse:
                subStatus = .trial
                trialStatus = .inUse
            case .used:
                subStatus = .basic
                trialStatus = .used
            }
        }
    }
    func getSubStatus() async {
        let freeTrialInfo = await freeTrialManager.checkFreeTrial()
        daysLeft = freeTrialInfo.daysLeft
        let freeTrialStatus = freeTrialInfo.freeTrialStatus
        if pro {
            subStatus = .pro
        } else {
            switch freeTrialStatus {
            case .unused:
                subStatus = .basic
                trialStatus = .unused
            case .inUse:
                subStatus = .trial
                trialStatus = .inUse
            case .used:
                subStatus = .basic
                trialStatus = .used
            }
        }
    }
    
    func makePurchase(product: AdaptyPaywallProduct) async -> Bool {
        pro = await AdaptyManager.shared.makePurchase(product: product)
        UserDefaults.standard.set(pro, forKey: "pro")
        await getSubStatus()
        if subStatus == .pro {
            return true
        } else {
            return false
        }
    }
    func restorePurchase() async -> Bool {
        pro = await AdaptyManager.shared.restorePurchase()
        UserDefaults.standard.set(pro, forKey: "pro")
        await getSubStatus()
        if subStatus == .pro {
            return true
        } else {
            return false
        }
    }
    
    func setUpFreeTrial() async {
        await freeTrialManager.getFreeTrial()
        await getSubStatus()
    }
    
}
