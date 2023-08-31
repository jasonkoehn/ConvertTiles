//
//  ReorderableForEach.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 2/15/23.
//

import SwiftUI
import UniformTypeIdentifiers

public struct ReorderableForEach<Data, Content>: View
where Data : Hashable, Content : View {
    @Binding var data: [Data]
    @Binding var allowReordering: Bool
    private let content: (Data, Bool) -> Content
    
    @State private var draggedItem: Data?
    @State private var hasChangedLocation: Bool = false
    
    public init(_ data: Binding<[Data]>,
                allowReordering: Binding<Bool>,
                @ViewBuilder content: @escaping (Data, Bool) -> Content) {
        _data = data
        _allowReordering = allowReordering
        self.content = content
    }
    
    public var body: some View {
        ForEach(data, id: \.self) { item in
            if allowReordering {
                content(item, hasChangedLocation && draggedItem == item)
                    .onDrag {
                        draggedItem = item
                        return NSItemProvider(object: "\(item.hashValue)" as NSString)
                    }
                    .onDrop(of: [UTType.plainText], delegate: ReorderDropDelegate(
                        item: item,
                        data: $data,
                        draggedItem: $draggedItem,
                        hasChangedLocation: $hasChangedLocation))
            } else {
                content(item, false)
            }
        }
    }
    
    struct ReorderDropDelegate<InnerData>: DropDelegate
    where InnerData : Equatable {
        let item: InnerData
        @Binding var data: [InnerData]
        @Binding var draggedItem: InnerData?
        @Binding var hasChangedLocation: Bool
        
        func dropEntered(info: DropInfo) {
            guard item != draggedItem,
                  let current = draggedItem,
                  let from = data.firstIndex(of: current),
                  let to = data.firstIndex(of: item)
            else {
                return
            }
            hasChangedLocation = true
            if data[to] != current {
                withAnimation {
                    data.move(fromOffsets: IndexSet(integer: from),
                              toOffset: (to > from) ? to + 1 : to)
                }
            }
        }
        
        func dropUpdated(info: DropInfo) -> DropProposal? {
            DropProposal(operation: .move)
        }
        
        func performDrop(info: DropInfo) -> Bool {
            hasChangedLocation = false
            draggedItem = nil
            return true
        }
    }
}


