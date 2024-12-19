//
//  clipboardManager.swift
//  clipboard
//
//  Created by Jopaul Joy on 19/12/24.
//

import Foundation
import AppKit


class ClipboardManager: ObservableObject {
    @Published var clipboardHistory: BoundedList<String> = BoundedList<String>(AppConfig.clipboardMaxLength);
    @Published var lastCopiedString: String?
    
    init() {
        startMonitoringClipboard()
        addAppToLoginItems()
    }
    
    public func getElementAtIndex(_ index: Int) -> String? {
        return clipboardHistory.getElementAtIndex(index)
    }

    private func startMonitoringClipboard() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let copiedString = NSPasteboard.general.string(forType: .string),
                copiedString != self.lastCopiedString {
                self.lastCopiedString = copiedString
                self.clipboardHistory.insert(copiedString)
            }
        }
    }
}
