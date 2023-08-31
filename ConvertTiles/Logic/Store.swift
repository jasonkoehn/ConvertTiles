//
//  Store.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 3/17/23.
//

import Foundation

class Store: ObservableObject {
    @Published var converters: [Converter] = []
    var appVersionNumber: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
    init() {
        loadConverters()
    }
    
    // Load
    func loadConverters() {
        let manager = FileManager.default
        let decoder = PropertyListDecoder()
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let convertersUrl = url.appendingPathComponent("converters.plist")
        if let data = try? Data(contentsOf: convertersUrl) {
            if let response = try? decoder.decode([Converter].self, from: data) {
                converters = response
            }
        }
    }
    
    // Save
    func saveConverters() {
        let manager = FileManager.default
        guard let managerUrl = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let encoder = PropertyListEncoder()
        let convertersUrl = managerUrl.appendingPathComponent("converters.plist")
        manager.createFile(atPath: convertersUrl.path, contents: nil, attributes: nil)
        let encodedData = try! encoder.encode(converters)
        try! encodedData.write(to: convertersUrl)
    }
}
