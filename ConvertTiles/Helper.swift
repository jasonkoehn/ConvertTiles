//
//  Helper.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 4/22/23.
//

import SwiftUI

class Helper: ObservableObject {
    enum InstallStatus: String {
        case new, update
    }
    
    enum AddedThings: String {
        case old, showedTrial, showedAll
    }
    
    @AppStorage("numOfLoads") var numOfLoads: Int = 0
    @AppStorage("installStatus") var installStatus: InstallStatus = .new
    @AppStorage("firstLaunch") var firstLaunch: Bool = true
}

