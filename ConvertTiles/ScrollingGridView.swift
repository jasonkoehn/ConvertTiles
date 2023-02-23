//
//  ScrollingGridView.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 2/15/23.
//

import SwiftUI

struct ScrollingGridView: View {
    @FocusState var isInputActive: Bool
    @AppStorage("haveAccentLines") var haveAccentLines: Bool = true
    @Binding var converters: [Converter]
    var accentColor: Color
    @Binding var isEditing: Bool
    @State var showAlert: Bool = false
    @State var deleteId: UUID?
    @State var selectedConverter: Converter? = nil
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 335))]) {
                ReorderableForEach($converters, allowReordering: $isEditing) { converter, isDragged in
                    ZStack {
                        TileView(converters: $converters, accentColor: accentColor, id: converter.id, name: converter.name, units: converter.units, inUnit: converter.inUnit, outUnit: converter.outUnit, singleUnits: converter.singleUnits, hasCustomColor: converter.hasCustomColor, hasAccentLine: converter.hasAccentLine, hasCustomAccentLineColor: converter.hasCustomAccentLineColor, customColor: decodeColor(color: converter.customColor), customAccentLineColor: decodeColor(color: converter.customAccentLineColor), isEditing: isEditing, isInputActive: _isInputActive)
                        if isEditing {
                            withAnimation(.easeInOut(duration: 5.0)) {
                                HStack {
                                    Button(action: {
                                        selectedConverter = Converter(id: converter.id, name: converter.name, units: converter.units, inUnit: converter.inUnit, outUnit: converter.outUnit, singleUnits: converter.singleUnits, hasCustomColor: converter.hasCustomColor, hasAccentLine: converter.hasAccentLine, hasCustomAccentLineColor: converter.hasCustomAccentLineColor, customColor: converter.customColor, customAccentLineColor: converter.customAccentLineColor)
                                    }) {
                                        Text("Edit")
                                            .foregroundColor(.blue)
                                            .font(.system(size: 22))
                                            .frame(width: 60, height: 60)
                                            .background(.black)
                                            .cornerRadius(15)
                                            .padding(.vertical, 8)
                                            .padding(.leading, 8)
                                            .padding(.trailing, 2)
                                    }
                                    Button(role: .destructive ,action: {
                                        deleteId = converter.id
                                        showAlert.toggle()
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                            .font(.system(size: 28))
                                            .frame(width: 60, height: 60)
                                            .background(.black)
                                            .cornerRadius(15)
                                            .padding(.vertical, 8)
                                            .padding(.leading, 2)
                                            .padding(.trailing, 8)
                                    }
                                }
                                .background(Color(.systemGray2))
                                .cornerRadius(8)
                                .padding(7)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 7)
        }
        .sheet(item: $selectedConverter) { converter in
            NavigationStack {
                EditConverterView(converters: $converters, accentColor: accentColor, id: converter.id, name: converter.name, units: converter.units, inUnit: converter.inUnit, outUnit: converter.outUnit, singleUnits: converter.singleUnits, hasCustomColor: converter.hasCustomColor, hasAccentLine: converter.hasAccentLine, hasCustomAccentLineColor: converter.hasCustomAccentLineColor, customColor: decodeColor(color: converter.customColor), customAccentLineColor: decodeColor(color: converter.customAccentLineColor))
            }
        }
        .alert("Are you sure you want to delete this converter?", isPresented: $showAlert, presenting: deleteId) { id in
            Button(role: .cancel ,action: {}) {
                Text("No")
            }
            Button(role: .destructive ,action: {
                if let idx = converters.firstIndex(where: {$0.id == id}) {
                    converters.remove(at: idx)
                }
            }) {
                Text("Yes")
            }
        }
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
