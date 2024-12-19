//
//  BlurBackground.swift
//  clipboard
//
//  Created by Jopaul Joy on 19/12/24.
//

import Foundation
import AppKit
import SwiftUI

struct BlurredBackground: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = .hudWindow
        view.state = .active
        view.blendingMode = .behindWindow
        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        // No updates needed
    }
}
