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
        List(clipboardManager.clipboardHistory.getList().indices, id: \.self) { index in
            if let item = clipboardManager.getElementAtIndex(index) {
                VStack{
                    Button(action:{
                        copyItemToClipboard(item: item)
                    }){
                        HStack {
                            
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
                    .buttonStyle(PlainButtonStyle())
                    .listRowSeparator(.hidden)
                }
                .listRowSeparator(.hidden)
                HStack{
                    Button(action: { copyItemToClipboard(item: item) }) {
                        Image(systemName: "clipboard.fill").foregroundColor(.yellow)
                    }
                    .buttonStyle(.plain)
                    Button(action: { deleteItem(index: index) }) {
                        Image(systemName: "trash.fill")
                    }
                    .buttonStyle(.plain)
                    Spacer()
                }
                .listRowSeparator(.hidden)
                .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 0))
                Divider().lineLimit(1)
            }
        }
        .scrollContentBackground(.hidden)
        .frame(width: 300, height: 400)
    }
    func deleteItem(index: Int){
        clipboardManager.removeElementAtIndex(index)
    }
}
