//
//  ContentView.swift
//  clipboard
//
//  Created by Jopaul Joy on 13/12/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var clipboardManager: ClipboardManager

    func copyItemToClipboard(item: String) {
        clipboardManager.lastCopiedString = item
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        if pasteboard.setString(item, forType: .string) {
            print("String copied to clipboard successfully.")
        } else {
            print("Failed to copy string to clipboard.")
        }
    }

    var body: some View {
        List(clipboardManager.clipboardHistory, id: \.self) { item in
            Button(action:{
                copyItemToClipboard(item: item)
            }){
                HStack {
                    Image(systemName: "clipboard.fill")
                        .foregroundColor(.yellow)
                    Text(item)
                        .font(.body)
                        .foregroundColor(.white)
                        .lineLimit(5)
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
                    Spacer()
                }
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                .listRowSeparator(.hidden)
            }
            .buttonStyle(.plain)
            .listRowSeparator(.hidden)
            Divider().lineLimit(1)
        }
        .frame(width: 300, height: 400)
    }
}
