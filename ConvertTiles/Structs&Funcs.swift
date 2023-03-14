//
//  Structs&Funcs.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 2/15/23.
//

import SwiftUI

class Store: ObservableObject {
    @Published var pro: Bool = false
}

struct Converter: Codable, Identifiable, Hashable {
    var id: UUID
    var name: String
    var units: [String]
    var inUnit: String
    var outUnit: String
    var singleUnits: Bool
    var hasCustomColor: Bool
    var hasAccentLine: Bool
    var hasCustomAccentLineColor: Bool
    var customColor: [CGFloat]
    var customAccentLineColor: [CGFloat]
}

func saveArray(converters: [Converter]) {
    let manager = FileManager.default
    guard let managerUrl = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
    let encoder = PropertyListEncoder()
    let convertersUrl = managerUrl.appendingPathComponent("converters.plist")
    manager.createFile(atPath: convertersUrl.path, contents: nil, attributes: nil)
    let encodedData = try! encoder.encode(converters)
    try! encodedData.write(to: convertersUrl)
}

func encodeColor(color: Color) -> [CGFloat] {
    let color = UIColor(color).cgColor
    let components = color.components ?? [0.0, 0.372549019607843, 0.96078431372549, 1.0]
    return components
}

func decodeColor(color: [CGFloat]) -> Color {
    let array = color
    let color = Color(red: array[0], green: array[1], blue: array[2], opacity: array[3])
    return color
}

func decodeUDColor(key: String) -> Color {
    guard let array = UserDefaults.standard.object(forKey: key) as? [CGFloat] else {return Color.blue}
    let color = Color(red: array[0], green: array[1], blue: array[2], opacity: array[3])
    return color
}

func formatAnswer(value: NSNumber) -> String {
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 4
    return formatter.string(from: value)!
}

extension Formatter {
    static let inNumberFormat: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol = ""
        return formatter
    }()
}

