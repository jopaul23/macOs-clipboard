//
//  clipboardManager.swift
//  clipboard
//
//  Created by Jopaul Joy on 19/12/24.
//

import Foundation
import AppKit


class ClipboardManager: ObservableObject {
    @Published private var clipboardHistory: PinnableBoundedList<String> = PinnableBoundedList<String>(AppConfig.clipboardMaxLength);
    private var lastCopiedString: String?
    
    init() {
        startMonitoringClipboard()
        addAppToLoginItems()
    }
    
    public func getClipboardItems() -> [String] {
        return clipboardHistory.getList()
    }
    
    public func getElementAtIndex(_ index: Int) -> String? {
        return clipboardHistory.getElementAtIndex(index)
    }
    
    public func removeElementAtOffset(_ offset: IndexSet) {
        clipboardHistory.removeItemAtOffset(offset)
    }
    
    public func removeElementAtIndex(_ index: Int) {
        clipboardHistory.removeItemAtIndex(index)
    }
    
    public func pinItem(_ index: Int) {
        clipboardHistory.pinItem(index)
    }
    
    public func unpinItem(_ index: Int) {
        clipboardHistory.unPinItem(index)
    }
    
    public func getPinnedIndex() -> Int {
        return clipboardHistory.getPinnedIndex()
    }

    public func copyItemToClipboard(item: String) {
        self.lastCopiedString = item
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        if pasteboard.setString(item, forType: .string) {
            print("String copied to clipboard successfully.")
        } else {
            print("Failed to copy string to clipboard.")
        }
    }
    
    private func startMonitoringClipboard() {
        Timer.scheduledTimer(withTimeInterval: AppConfig.fetchInterval, repeats: true) { _ in
            if let copiedString = NSPasteboard.general.string(forType: .string),
                copiedString != self.lastCopiedString {
                self.lastCopiedString = copiedString
                self.clipboardHistory.insert(copiedString)
            }
        }
    }
}
