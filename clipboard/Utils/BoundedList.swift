//
//  BoundedList.swift
//  clipboard
//
//  Created by Jopaul Joy on 19/12/24.
//

import Foundation

struct BoundedList<T> {
    private var maxLength: Int
    private var data: [T]

    init(_ maxLength: Int) {
        self.maxLength = maxLength
        self.data = []
    }

    mutating func insert(_ item: T) {
        // Inserts the item at the front
        data.insert(item, at: 0)
        
        // Ensure the list doesn't exceed the max length
        while data.count > maxLength {
            // Remove item from the back
            data.removeLast()
        }
    }
    
    func getElementAtIndex(_ index: Int) -> T? {
        return data[safe: index]
    }
    
    func getList() -> [T] {
        return data
    }
}
