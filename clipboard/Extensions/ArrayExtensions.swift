//
//  ArrayExtensions.swift
//  clipboard
//
//  Created by Jopaul Joy on 19/12/24.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
