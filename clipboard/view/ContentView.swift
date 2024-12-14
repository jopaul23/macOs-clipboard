import SwiftUI

struct ContentView: View {
    @EnvironmentObject var clipboardManager: ClipboardManager
    var body: some View {
        List(clipboardManager.clipboardHistory, id: \.self) { item in
            Button(action: {
                clipboardManager.lastCopiedString = item
                let pasteboard = NSPasteboard.general
                pasteboard.clearContents()
                if pasteboard.setString(item, forType: .string) {
                    print("String copied to clipboard successfully.")
                } else {
                    print("Failed to copy string to clipboard.")
                }
            }) {
                HStack {
                    Image(systemName: "clipboard.fill")
                        .foregroundColor(.yellow)
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
