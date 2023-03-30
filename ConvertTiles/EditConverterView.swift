//
//  EditConverterView.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 2/15/23.
//

import SwiftUI

struct EditConverterView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: Store
    var accentColor: Color
    @State var haveAccentLines: Bool
    @State var id: UUID
    @State var name: String
    @State var units: [String]
    @State var inUnit: String
    @State var outUnit: String
    @State var singleUnits: Bool
    @State var hasCustomColor: Bool
    @State var hasAccentLine: Bool
    @State var hasCustomAccentLineColor: Bool
    @State var customColor: Color
    @State var customAccentLineColor: Color
    var body: some View {
        VStack {
            TilePreView(accentColor: accentColor, name: name, units: units, inUnit: $inUnit, outUnit: $outUnit, singleUnits: singleUnits, hasCustomColor: hasCustomColor, hasAccentLine: hasAccentLine, customColor: customColor, customAccentLineColor: customAccentLineColor)
            List {
                HStack {
                    Text("Name:")
                    TextField("", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.done)
                }
                Toggle("Custom Color?", isOn: $hasCustomColor)
                    .onChange(of: hasCustomColor) { hcc in
                        if hcc {
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
            .listStyle(.inset)
        }
        .navigationTitle("Edit Converter")
        .toolbar {
            Button(action: {
                if let idx = store.converters.firstIndex(where: {$0.id == id}) {
                    store.converters[idx].name = name
                    store.converters[idx].hasCustomColor = hasCustomColor
                    store.converters[idx].hasAccentLine = hasAccentLine
                    store.converters[idx].hasCustomAccentLineColor = hasCustomAccentLineColor
                    store.converters[idx].customColor = encodeColor(color: customColor)
                    store.converters[idx].customAccentLineColor = encodeColor(color: customAccentLineColor)
                }
                dismiss()
            }) {
                Text("Save")
            }
        }
    }
}
