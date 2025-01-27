//
//  BoundedList.swift
//  clipboard
//
//  Created by Jopaul Joy on 19/12/24.
//

import Foundation

struct PinnableBoundedList<T> {
    private var pinnedIndex: Int
    private var maxLength: Int
    private var data: [T]

    init(_ maxLength: Int) {
        self.maxLength = maxLength
        self.pinnedIndex = 0
        self.data = []
    }

    func getElementAtIndex(_ index: Int) -> T? {
        return data[safe: index]
    }
    
    func getPinnedIndex() -> Int {
        return pinnedIndex
    }
    
    mutating func insert(_ item: T) {
        // Inserts the item at the front
        data.insert(item, at: pinnedIndex)
        
        // Ensure the list doesn't exceed the max length
        while data.count > maxLength {
            // Remove item from the back
            data.removeLast()
        }
    }
    
    mutating func pinItem(_ index: Int) {
        // Ensure the index is within bounds
        guard index >= 0 && index < self.data.count else { return }
        
        let pinnedItem: T =  self.data.remove(at: index)
        self.insert(pinnedItem)
        pinnedIndex += 1
    }
    
    mutating func unPinItem(_ index: Int) {
        // Ensure the index is within bounds
        guard index >= 0 && index < self.data.count else { return }
        
        pinnedIndex -= 1
        let unpinnedItem: T =  self.data.remove(at: index)
        data.insert(unpinnedItem, at: pinnedIndex)
    }
    
    mutating func removeItemAtOffset(_ indexSet: IndexSet) {
        self.data.remove(atOffsets: indexSet)
    }
    
    mutating func removeItemAtIndex(_ index: Int) {
        self.data.remove(at: index)
    }
    
    func getList() -> [T] {
        return data
    }
}
