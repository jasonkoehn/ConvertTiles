//
//  FreeTrialManager.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 7/24/23.
//

import Foundation

enum FreeTrialStatus: String {
    case unused
    case inUse
    case used
}

class FreeTrialManager: ObservableObject {
    
    let freeTrialKeychainKey = "freeTrialKey"
    
    func checkFreeTrial() async -> (freeTrialStatus: FreeTrialStatus, daysLeft: Int) {
        var freeTrialStatus: FreeTrialStatus = .unused
        var daysLeft: Int = 0
        let trialExpirationDate = await KeychainManager().get(key: freeTrialKeychainKey)
        if trialExpirationDate == "" {
            freeTrialStatus = .unused
        } else {
            daysLeft = checkDaysLeft(trialExpirationDate: trialExpirationDate)
            if daysLeft < 0 {
                freeTrialStatus = .used
            } else {
                freeTrialStatus = .inUse
            }
        }
        return (freeTrialStatus, daysLeft)
    }
    
    func checkDaysLeft(trialExpirationDate: String) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let expirationDate = formatter.date(from: trialExpirationDate) ?? Date()
        let daysBetween = Calendar.current.dateComponents([.day], from: Date(), to: expirationDate).day!
        let formatedCurrentDate = formatter.string(from: Date())
        if trialExpirationDate == formatedCurrentDate {
            return 0
        } else if daysBetween < 0 {
            return daysBetween
        } else {
            return daysBetween
        }
    }
    
    func getFreeTrial() async {
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = 10
        let expirationDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        await KeychainManager().save(data: formatter.string(from: expirationDate!), key: freeTrialKeychainKey)
    }
    
    // DEBUG
    func deleteFreeTrial() async {
        await KeychainManager().delete(key: freeTrialKeychainKey)
    }
}
