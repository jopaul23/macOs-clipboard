//
//  ContentView.swift
//  clipboard
//
//  Created by Jopaul Joy on 13/12/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var clipboardManager: ClipboardManager

    var body: some View {
        List(clipboardManager.getClipboardItems().indices, id: \.self) { index in
            if let item = clipboardManager.getElementAtIndex(index) {
                VStack{
                    Button(action:{
                        clipboardManager.copyItemToClipboard(item: item)
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
                    Button(action: { clipboardManager.copyItemToClipboard(item: item) }) {
                        Image(systemName: "clipboard.fill").foregroundColor(.yellow)
                    }
                    .buttonStyle(.plain)
                    Button(action: { clipboardManager.removeElementAtIndex(index) }) {
                        Image(systemName: "trash.fill")
                    }
                    .buttonStyle(.plain)
                    Button(action: {
                        if ( index < clipboardManager.getPinnedIndex()){
                            clipboardManager.unpinItem(index)
                        } else {
                            clipboardManager.pinItem(index)
                        }
                    }) {
                        Image(systemName: index < clipboardManager.getPinnedIndex() ? "pin.fill" : "pin")
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
}
