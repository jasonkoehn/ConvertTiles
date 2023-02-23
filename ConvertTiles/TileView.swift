//
//  TileView.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 2/15/23.
//

import SwiftUI

struct TileView: View {
    @Binding var converters: [Converter]
    var accentColor: Color
    var id: UUID
    var name: String
    var units: [String]
    @State var inUnit: String
    @State var outUnit: String
    var singleUnits: Bool
    var hasCustomColor: Bool
    var hasAccentLine: Bool
    var hasCustomAccentLineColor: Bool
    var customColor: Color
    var customAccentLineColor: Color
    @State var isEditing: Bool
    @FocusState var isInputActive: Bool
    @State var initialValue: Double = 1
    var body: some View {
        ZStack {
            VStack {
                Text(name)
                    .foregroundColor(.primary)
                    .font(.title)
                    .padding(.top, 5)
                HStack {
                    Spacer().overlay {
                        VStack {
                            if singleUnits {
                                Text(inUnit)
                                    .foregroundColor(hasCustomColor ? customColor : accentColor)
                                    .padding(.vertical, 12)
                            } else {
                                Picker("", selection: $inUnit) {
                                    ForEach(units, id: \.self) { unit in
                                        Text(unit).tag(unit)
                                    }
                                }
                                .accentColor(hasCustomColor ? customColor : accentColor)
                                .padding(.vertical, 5)
                                .disabled(isEditing)
                            }
                            TextField("Value", value: $initialValue, formatter: Formatter.inNumberFormat)
                                .textFieldStyle(.roundedBorder)
                                .font(.title3)
                                .frame(width: 100)
                                .keyboardType(.decimalPad)
                                .focused($isInputActive)
                                .disabled(isEditing)
                                .onTapGesture {
                                    initialValue = 0
                                }
                                .onChange(of: isInputActive) { input in
                                    if input == false && initialValue == 0 {
                                        initialValue = 1
                                    }
                                }
                        }
                    }
                    .frame(height: 80)
                    Button(action: {
                        let unit = inUnit
                        inUnit = outUnit
                        outUnit = unit
                    }) {
                        Image(systemName: "arrow.right")
                            .foregroundColor(hasCustomColor ? customColor : accentColor)
                            .font(.title2)
                    }
                    .disabled(isEditing)
                    Spacer().overlay {
                        VStack {
                            if singleUnits {
                                Text(outUnit)
                                    .foregroundColor(hasCustomColor ? customColor : accentColor)
                                    .padding(.vertical, 12)
                            } else {
                                Picker("", selection: $outUnit) {
                                    ForEach(units, id: \.self) { unit in
                                        Text(unit).tag(unit)
                                    }
                                }
                                .accentColor(hasCustomColor ? customColor : accentColor)
                                .padding(.vertical, 5)
                                .disabled(isEditing)
                            }
                            Text(formatAnswer(value: Measurement(value: initialValue, unit: StringToDimension(unit: inUnit)).converted(to: StringToDimension(unit: outUnit)).value as NSNumber))
                                .font(.system(size: 25))
                                .textSelection(.enabled)
                        }
                    }
                    .frame(height: 80)
                }
                Spacer()
            }
            .frame(height: 150)
            .opacity(isEditing ? 0.5 : 1.0)
            .background(Color(.systemGray5))
            .cornerRadius(8)
            .padding(4)
        }
        .background(hasAccentLine ? (hasCustomAccentLineColor ? customAccentLineColor.opacity(isEditing ? 0.5 : 1.0) : (hasCustomColor ? customColor.opacity(isEditing ? 0.5 : 1.0) : accentColor.opacity(isEditing ? 0.5 : 1.0))) : Color(.systemGray5))
        .cornerRadius(10)
        .onChange(of: inUnit) { _ in
            if let idx = converters.firstIndex(where: {$0.id == id}) {
                converters[idx].inUnit = inUnit
            }
        }
        .onChange(of: outUnit) { _ in
            if let idx = converters.firstIndex(where: {$0.id == id}) {
                converters[idx].outUnit = outUnit
            }
        }
    }
}
