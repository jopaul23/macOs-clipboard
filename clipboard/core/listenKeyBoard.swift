//
//  listenKeyBoard.swift
//  clipboard
//
//  Created by Jopaul Joy on 14/12/24.
//

import Foundation
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    var globalEventMonitor: Any?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Set up a global event monitor for a specific shortcut (e.g., Command + Option + P)
        globalEventMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
            if event.modifierFlags.contains([.command, .option]) && event.charactersIgnoringModifiers == "p" {
                self.handleGlobalShortcut()
            }
        }
    }

    func handleGlobalShortcut() {
        print("Global shortcut triggered!")
        // Perform the action you want to handle here.
    }
}
