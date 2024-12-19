//
//  clipboardApp.swift
//  clipboard
//
//  Created by Jopaul Joy on 13/12/24.
//

import SwiftUI

@main
struct clipboardApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    var body: some Scene {
        Settings {
              Text("Settings or main app window")
        }
    }
}
