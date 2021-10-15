//
//  HistoryCell.swift
//  BoxFinder
//
//  Created by Romain Penchenat on 14/10/2021.
//

import SwiftUI
import QuickLookThumbnailing

struct HistoryCell: View {
    
    @State var hovered = false
    @State var isCopied = false
    @State var thumbnail:NSImage? = nil
    var path:String
    var fileName: String? {
        URL(string: path)?.lastPathComponent
    }
    
    var body: some View {
        HStack {
            if let thumbnail = thumbnail {
                Image(nsImage: thumbnail)
                    .frame(width: 40, height: 40)
            }
            VStack(alignment: .leading) {
                Text(fileName ?? "unknown")
                    .font(.body)
                    .foregroundColor(Color.bfText)
                if isCopied {
                    Text("Copied to clipboard")
                        .font(.caption)
                        .foregroundColor(Color.bfText)
                }
            }
            Spacer()
            IconButton(action: copyAction, imageName: "copy")
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .background(hovered ? Color.bfZ1 : Color.bfZ0)
        .onHover { isHovered in
            hovered = isHovered
        }
        .onTapGesture(perform: openAction)
        .onAppear(perform: loadThumbnail)
    }
    
    private func loadThumbnail() {
        guard let fileURL = URLManager.boxFinderPathToFinderURL(path: path) else { return }
        let request = QLThumbnailGenerator.Request(fileAt: fileURL, size: CGSize(width: 48, height: 48), scale: 3, representationTypes: .thumbnail)
        QLThumbnailGenerator.shared.generateBestRepresentation(for: request) { thumbnail, error in
            if let error = error {
                print(error)
            }
            print(thumbnail)
            self.thumbnail = thumbnail?.nsImage
        }
    }
    
    private func copyAction() {
        NSPasteboard.general.copyBoxFinderUrl(path: path)
        UserDefaults.appgroup?.savePathToHistory(path)
        withAnimation {
            isCopied = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                isCopied = false
            }
        }
    }
    
    private func openAction() {
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.openInFinder(path: path)
    }
    
}

struct HistoryCell_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCell(path: "Heyyyy")
    }
}
