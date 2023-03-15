//
//  AddConverterView.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 2/15/23.
//

import SwiftUI

struct AddConverterView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var converters: [Converter]
    @AppStorage("pro") var pro: Bool = false
    var accentColor: Color = decodeUDColor(key: "accentColor")
    @State var haveAccentLines: Bool
    @State var group: String = ""
    @State var name: String = ""
    @State var units: [String] = []
    @State var inUnit: String = ""
    @State var outUnit: String = ""
    @State var singleUnits: Bool = false
    @State var hasCustomColor: Bool = false
    @State var hasAccentLine: Bool
    @State var hasCustomAccentLineColor: Bool = false
    @State var customColor: Color = decodeUDColor(key: "accentColor")
    @State var customAccentLineColor: Color = decodeUDColor(key: "accentColor")
    @State var hasCustomUnits: Bool = false
    @State var customUnits: [String] = []
    var body: some View {
        VStack {
            if pro {
                // Full Access
                if group != "" {
                    TilePreView(accentColor: accentColor, name: name, units: hasCustomUnits ? customUnits : units, inUnit: $inUnit, outUnit: $outUnit, singleUnits: singleUnits, hasCustomColor: hasCustomColor, hasAccentLine: haveAccentLines ? hasAccentLine : false, customColor: customColor, customAccentLineColor: customAccentLineColor)
                }
                List {
                    NavigationLink(destination: GroupPicker(name: $name, group: $group, units: $units, inUnit: $inUnit, outUnit: $outUnit)) {
                        HStack {
                            Text("Group:")
                            Spacer()
                            if group != "" {
                                Text(group)
                                    .foregroundColor(.blue)
                            } else {
                                Text("Choose a group to get started.")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    if group != "" {
                        HStack {
                            Text("Name:")
                            TextField("", text: $name)
                                .textFieldStyle(.roundedBorder)
                        }
                        Picker("", selection: $singleUnits) {
                            Text("All Units").tag(false)
                            Text("Single Units").tag(true)
                        }
                        .pickerStyle(.segmented)
                        if singleUnits {
                            Picker("In Unit:", selection: $inUnit) {
                                ForEach(units, id: \.self) { unit in
                                    Text(unit).tag(unit)
                                }
                            }
                            .pickerStyle(.menu)
                            Picker("Out Unit:", selection: $outUnit) {
                                ForEach(units, id: \.self) { unit in
                                    Text(unit).tag(unit)
                                }
                            }
                            .pickerStyle(.menu)
                        } else {
                            Toggle("Custom Units?", isOn: $hasCustomUnits)
                            if hasCustomUnits {
                                NavigationLink(destination: CustomUnitsPicker(units: units, customUnits: $customUnits, inUnit: $inUnit, outUnit: $outUnit)) {
                                    Text("Custom Units:")
                                }
                                if customUnits != [] {
                                    Picker("Initial In Unit:", selection: $inUnit) {
                                        ForEach(units, id: \.self) { unit in
                                            Text(unit).tag(unit)
                                        }
                                    }
                                    .pickerStyle(.menu)
                                    Picker("Initial Out Unit:", selection: $outUnit) {
                                        ForEach(units, id: \.self) { unit in
                                            Text(unit).tag(unit)
                                        }
                                    }
                                    .pickerStyle(.menu)
                                }
                            } else {
                                Picker("Initial In Unit:", selection: $inUnit) {
                                    ForEach(units, id: \.self) { unit in
                                        Text(unit).tag(unit)
                                    }
                                }
                                .pickerStyle(.menu)
                                Picker("Initial Out Unit:", selection: $outUnit) {
                                    ForEach(units, id: \.self) { unit in
                                        Text(unit).tag(unit)
                                    }
                                }
                                .pickerStyle(.menu)
                            }
                        }
                        Toggle("Custom Color?", isOn: $hasCustomColor)
                            .onChange(of: hasCustomColor) { hcc in
                                if !hcc {
                                    customColor = accentColor
                                }
                            }
                        if hasCustomColor {
                            ColorPicker("Custom Color:", selection: $customColor)
                                .onChange(of: customColor) { _ in
                                    if !hasCustomAccentLineColor {
                                        customAccentLineColor = customColor
                                    }
                                }
                        }
                        Toggle("Accent Line?", isOn: $hasAccentLine)
                            .onChange(of: hasAccentLine) { hal in
                                if !hal {
                                    customAccentLineColor = customColor
                                    hasCustomAccentLineColor = false
                                }
                            }
                        if hasAccentLine {
                            Toggle("Custom Accent Line Color?", isOn: $hasCustomAccentLineColor)
                                .onChange(of: hasCustomAccentLineColor) { hcal in
                                    if !hcal {
                                        customAccentLineColor = customColor
                                    }
                                }
                            if hasCustomAccentLineColor {
                                ColorPicker("Custom Accent Line Color:", selection: $customAccentLineColor)
                            }
                        }
                        if !haveAccentLines && hasAccentLine {
                            Text("Accent line will not show unless it is turned on in settings.")
                                .foregroundColor(.secondary)
                                .font(.system(size: 13))
                                .listRowSeparator(.hidden, edges: .bottom)
                        }
                    }
                }
                .listStyle(.inset)
            } else {
                // Basic Access
                BasicGroupPicker(name: $name, units: $units, inUnit: $inUnit, outUnit: $outUnit)
            }
        }
        .navigationTitle("Add Converter")
        .toolbar {
            if group == "" {
                if !pro && name != "" {
                    Button(action: {
                        converters.append(Converter(id: UUID(), name: name, units: units, inUnit: inUnit, outUnit: outUnit, singleUnits: false, hasCustomColor: false, hasAccentLine: false, hasCustomAccentLineColor: false, customColor: encodeColor(color: customColor), customAccentLineColor: encodeColor(color: customAccentLineColor)))
                        dismiss()
                    }) {
                        Text("Add")
                    }
                } else {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                    }
                }
            } else {
                Button(action: {
                    converters.append(Converter(id: UUID(), name: name, units: hasCustomUnits ? customUnits : units, inUnit: inUnit, outUnit: outUnit, singleUnits: singleUnits, hasCustomColor: hasCustomColor, hasAccentLine: hasAccentLine, hasCustomAccentLineColor: hasCustomAccentLineColor, customColor: encodeColor(color: customColor), customAccentLineColor: encodeColor(color: customAccentLineColor)))
                    dismiss()
                }) {
                    Text("Add")
                }
            }
        }
    }
}

struct GroupPicker: View {
    struct ConverterList {
        var group: String
        var units: [String]
    }
    var convertersList: [ConverterList] = [ConverterList(group: "Acceleration", units: ["Meters Per Second Squared", "Gravity"]), ConverterList(group: "Angle", units: ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]), ConverterList(group: "Area", units: ["Square Megameters", "Square Kilometers", "Square Meters", "Square Centimeters", "Square Millimeters", "Square Micrometers", "Square Nanometers", "Square Inches", "Square Feet", "Square Yards", "Square Miles", "Acres", "Ares", "Hectares"]), ConverterList(group: "Concentration Mass", units: ["Grams Per Liter", "Milligrams Per Deciliter"]), ConverterList(group: "Duration", units: ["Seconds", "Minutes", "Hours"]), ConverterList(group: "Electric Charge", units: ["Coulombs", "Megaampere Hours", "Kiloampere Hours", "Ampere Hours", "Milliampere Hours", "Microampere Hours"]), ConverterList(group: "Electric Current", units: ["Megaamperes", "Kiloamperes", "Amperes", "Milliamperes", "Microamperes"]), ConverterList(group: "Electric Potential Difference", units: ["Megavolts", "Kilovolts", "Volts", "Millivolts", "Microvolts"]), ConverterList(group: "Electric Resistance", units: ["Megaohms", "Kiloohms", "Ohms", "Milliohms", "Microohms"]), ConverterList(group: "Energy", units: ["Kilojoules", "Joules", "Kilocalories", "Calories", "Kilowatt Hours"]), ConverterList(group: "Frequency", units: ["Terahertz", "Gigahertz", "Megahertz", "Kilohertz", "Hertz", "Millihertz", "Microhertz", "Nanohertz"]), ConverterList(group: "Fuel Efficiency", units: ["Liters Per 100 Kilometers", "Miles Per Gallon", "Miles Per Imperial Gallon"]), ConverterList(group: "Information Storage", units: ["Bits", "Kilobits", "Megabits", "Gigabits", "Terabits", "Petabits", "Exabits", "Zettabits", "Yottabits", "Bytes", "Kilobytes", "Megabytes", "Gigabytes", "Terabytes", "Petabytes", "Exabytes", "Zettabytes", "Yottabytes"]), ConverterList(group: "Length", units: ["Megameters", "Kilometers", "Hectometers", "Decameters", "Meters", "Decimeters", "Centimeters", "Millimeters", "Micrometers", "Nanometers", "Picometers", "Inches", "Feet", "Yards", "Miles", "Scandinavian Miles", "Light Years", "Nautical Miles", "Fathoms", "Furlongs", "Astronomical Units", "Parsecs"]), ConverterList(group: "Mass", units: ["Kilograms", "Grams", "Decigrams", "Centigrams", "Milligrams", "Micrograms", "Nanograms", "Picograms", "Ounces", "Pounds", "Stones", "MetricTons", "ShortTons", "Carats", "OuncesTroy", "Slugs"]), ConverterList(group: "Power", units: ["Terawatts", "Gigawatts", "Megawatts", "Kilowatts", "Watts", "Milliwatts", "Microwatts", "Nanowatts", "Picowatts", "Femtowatts", "Horsepower"]), ConverterList(group: "Pressure", units: ["Newtons Per Meter Squared", "Gigapascals", "Megapascals", "Kilopascals", "Hectopascals", "Inches of Mercury", "Bars", "Millibars", "Millimeters of Mercury", "Pounds Per Square Inch"]), ConverterList(group: "Speed", units: ["Meters Per Second", "Kilometers Per Hour", "Miles Per Hour", "Knots"]), ConverterList(group: "Temperature", units: ["Kelvin", "Celsius", "Fahrenheit"]), ConverterList(group: "Volume", units: ["Megaliters", "Kiloliters", "Liters", "Deciliters", "Centiliters", "Milliliters", "Cubic Kilometers", "Cubic Meters", "Cubic Decimeters", "Cubic Millimeters", "Cubic Inches", "Cubic Feet", "Cubic Yards", "Cubic Miles", "Acre Feet", "Bushels", "Teaspoons", "Tablespoons", "Fluid Ounces", "Cups", "Pints", "Quarts", "Gallons", "Imperial Teaspoons", "Imperial Tablespoons", "Imperial Fluid Ounces", "Imperial Pints", "Imperial Quarts", "Imperial Gallons", "Metric Cups"])]
    @Environment(\.dismiss) var dismiss
    @Binding var name: String
    @Binding var group: String
    @Binding var units: [String]
    @Binding var inUnit: String
    @Binding var outUnit: String
    var body: some View {
        List {
            ForEach(convertersList, id: \.group) { converter in
                Button(action: {
                    name = converter.group
                    group = converter.group
                    units = converter.units
                    inUnit = converter.units.first ?? ""
                    outUnit = converter.units.first ?? ""
                    dismiss()
                }) {
                    HStack {
                        Text(converter.group)
                            .foregroundColor(.primary)
                        if group == converter.group {
                            Spacer()
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        }
    }
}

struct CustomUnitsPicker: View {
    var units: [String]
    @Binding var customUnits: [String]
    @Binding var inUnit: String
    @Binding var outUnit: String
    var body: some View {
        List {
            ForEach(units, id: \.self) { unit in
                Button(action: {
                    if customUnits.contains(unit) {
                        customUnits.removeAll(where: {$0 == unit})
                    } else {
                        customUnits.append(unit)
                    }
                }) {
                    HStack {
                        Text(unit)
                            .foregroundColor(.primary)
                        if customUnits.contains(unit) {
                            Spacer()
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        }
        .onDisappear {
            inUnit = customUnits.first ?? ""
            outUnit = customUnits.first ?? ""
        }
    }
}

struct BasicGroupPicker: View {
    struct BasicConverterList {
        var name: String
        var units: [String]
        var inUnit: String
        var outUnit: String
    }
    var convertersList: [BasicConverterList] = [BasicConverterList(name: "Area", units: ["Square Kilometers", "Square Meters", "Square Centimeters", "Square Millimeters", "Square Inches", "Square Feet", "Square Yards", "Square Miles", "Acres", "Hectares"], inUnit: "Square Meters", outUnit: "Square Feet"), BasicConverterList(name: "Length", units: ["Kilometers", "Meters", "Decimeters", "Centimeters", "Millimeters", "Inches", "Feet", "Yards", "Miles", "Nautical Miles"], inUnit: "Meters", outUnit: "Feet"), BasicConverterList(name: "Mass", units: ["Kilograms", "Grams", "Centigrams", "Milligrams", "Ounces", "Pounds", "MetricTons", "ShortTons"], inUnit: "Kilograms", outUnit: "Pounds"), BasicConverterList(name: "Speed", units: ["Meters Per Second", "Kilometers Per Hour", "Miles Per Hour", "Knots"], inUnit: "Miles Per Hour", outUnit: "Kilometers Per Hour"), BasicConverterList(name: "Temperature", units: ["Kelvin", "Celsius", "Fahrenheit"], inUnit: "Celsius", outUnit: "Fahrenheit"), BasicConverterList(name: "Volume", units: ["Megaliters", "Liters", "Milliliters", "Cubic Meters", "Cubic Millimeters", "Cubic Inches", "Cubic Feet", "Cubic Yards", "Acre Feet", "Bushels", "Teaspoons", "Tablespoons", "Fluid Ounces", "Cups", "Pints", "Quarts", "Gallons", "Imperial Teaspoons", "Imperial Tablespoons", "Imperial Fluid Ounces", "Imperial Pints", "Imperial Quarts", "Imperial Gallons", "Metric Cups"], inUnit: "Liters", outUnit: "Quarts")]
    @Binding var name: String
    @Binding var units: [String]
    @Binding var inUnit: String
    @Binding var outUnit: String
    var body: some View {
        List {
            ForEach(convertersList, id: \.name) { converter in
                Button(action: {
                    name = converter.name
                    units = converter.units
                    inUnit = converter.inUnit
                    outUnit = converter.outUnit
                }) {
                    HStack {
                        Text(converter.name)
                            .foregroundColor(.primary)
                        if name == converter.name {
                            Spacer()
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        }
        .listStyle(.inset)
    }
}
