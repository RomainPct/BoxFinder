//
//  HistoryCell.swift
//  BoxFinder
//
//  Created by Romain Penchenat on 14/10/2021.
//

import SwiftUI

struct HistoryCell: View {
    
    @State var hovered = false
    @State var isCopied = false
    var path:String
    var fileName: String? {
        URL(string: path)?.lastPathComponent
    }
    
    var body: some View {
        HStack {
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
