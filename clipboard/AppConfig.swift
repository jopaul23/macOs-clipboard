//
//  AppConfig.swift
//  clipboard
//
//  Created by Jopaul Joy on 19/12/24.
//

import Foundation

enum AppConfig {
    //maximum number of items in clipboard
    static let clipboardMaxLength: Int = 30
    static let windowSize: NSSize = NSSize(width: 300, height: 400)
    static let fetchInterval: TimeInterval = 1.0
}
