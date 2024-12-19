//
//  AppDelegate.swift
//  clipboard
//
//  Created by Jopaul Joy on 19/12/24.
//

import Foundation
import AppKit
import SwiftUI


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
        self.popOver.contentViewController = NSHostingController(rootView: ContentView().environmentObject(clipboardManager).background(BlurredBackground()))
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
