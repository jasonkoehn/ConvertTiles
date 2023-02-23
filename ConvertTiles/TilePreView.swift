//
//  TilePreView.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 2/16/23.
//

import SwiftUI

struct TilePreView: View {
    var accentColor: Color
    var name: String
    var units: [String]
    @Binding var inUnit: String
    @Binding var outUnit: String
    var singleUnits: Bool
    var hasCustomColor: Bool
    var hasAccentLine: Bool
    var customColor: Color
    var customAccentLineColor: Color
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
                            }
                            TextField("Value", value: $initialValue, formatter: Formatter.inNumberFormat)
                                .textFieldStyle(.roundedBorder)
                                .font(.title3)
                                .frame(width: 100)
                                .keyboardType(.decimalPad)
                                .focused($isInputActive)
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
                                .padding(.vertical, 5)
                                .accentColor(hasCustomColor ? customColor : accentColor)
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
            .background(Color(.systemGray5))
            .cornerRadius(8)
            .padding(4)
        }
        .background(hasAccentLine ? customAccentLineColor : Color(.systemGray5))
        .cornerRadius(10)
        .padding(.horizontal, 7)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isInputActive = false
                }
            }
        }
    }
}
