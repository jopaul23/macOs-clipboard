//
//  clipboardApp.swift
//  clipboard
//
//  Created by Jopaul Joy on 13/12/24.
//

import SwiftUI

@main
struct clipboardApp: App {
    @StateObject private var clipboardManager = ClipboardManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(clipboardManager)
        }
    }
}

class ClipboardManager: ObservableObject {
    @Published var clipboardHistory: [String] = []
    @Published var lastCopiedString: String?
    
    init() {
        startMonitoringClipboard()
        addAppToLoginItems()
    }

    private func startMonitoringClipboard() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let copiedString = NSPasteboard.general.string(forType: .string), 
                copiedString != self.lastCopiedString {
                self.lastCopiedString = copiedString
                self.clipboardHistory.insert(copiedString, at: 0)
            }
        }
    }
}

