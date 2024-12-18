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

class AppDelegate: NSObject, NSApplicationDelegate {
    @StateObject private var clipboardManager = ClipboardManager()
    private var statusItem: NSStatusItem!
    private var popOver: NSPopover!
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button{
            statusButton.image = NSImage(systemSymbolName: "clipboard", accessibilityDescription: "clipboard")
            statusButton.action = #selector(togglePopover)
        }
        
        self.popOver = NSPopover()
        self.popOver.contentSize = NSSize(width: 300, height: 400)
        self.popOver.behavior = .transient
        self.popOver.contentViewController = NSHostingController(rootView: ContentView().environmentObject(clipboardManager))
    }
    
    @objc func togglePopover(){
        if let button = statusItem.button{
            if popOver.isShown{
                self.popOver.performClose(nil)
            }else{
                popOver.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}
