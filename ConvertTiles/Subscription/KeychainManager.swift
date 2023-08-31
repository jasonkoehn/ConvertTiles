//
//  KeychainManager.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 7/24/23.
//

import Foundation
import KeychainAccess

class KeychainManager {
    let keychain = Keychain(service: "com.jasonkoehn.ConvertTiles")
    
    func save(data: String, key: String) async {
        keychain[key] = data
    }
    func get(key: String) async -> String {
        return keychain[key] ?? ""
    }
    func delete(key: String) async {
        keychain[key] = nil
    }
}


