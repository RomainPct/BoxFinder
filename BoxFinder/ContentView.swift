//
//  ContentView.swift
//  BoxFinder
//
//  Created by Romain Penchenat on 09/10/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var dropboxFolder:URL? = UserDefaults.appgroup?.url(forKey: UserDefaults.KEY.dropboxFolderURL)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Dropbox folder v0.1")
                    .lineLimit(0)
                Text("(\(dropboxFolder?.path ?? "unknown"))")
                    .lineLimit(0)
                RowButton(text: "Change dropbox root folder", action: pickDropboxRootAction)
            }
            VStack(alignment: .leading, spacing: 8) {
                RowButton(text: "Share the app", action: shareAction)
                RowButton(text: "Contact developers", action: contactAction)
                RowButton(text: "Quit BoxFinder", action: exitAction)
            }
        }
        .padding(.all, 16)
    }
    
    private func pickDropboxRootAction() {
        let folderChooserPoint = CGPoint(x: 0, y: 0)
        let folderChooserSize = CGSize(width: 500, height: 600)
        let folderChooserRectangle = CGRect(origin: folderChooserPoint, size: folderChooserSize)
        let folderPicker = NSOpenPanel(contentRect: folderChooserRectangle, styleMask: .utilityWindow, backing: .buffered, defer: true)

        folderPicker.canChooseDirectories = true
        folderPicker.canChooseFiles = false
        folderPicker.allowsMultipleSelection = false
        folderPicker.canDownloadUbiquitousContents = true
        folderPicker.canResolveUbiquitousConflicts = true

        folderPicker.begin { response in
            guard response == .OK else { return }
            guard let folder = folderPicker.url else { return }
            dropboxFolder = folder
            UserDefaults.appgroup?.set(folder, forKey: UserDefaults.KEY.dropboxFolderURL)
        }
    }
    
    private func shareAction() {
        print("Share")
    }
    
    private func contactAction() {
        print("Contact")
    }
    
    private func exitAction() {
        exit(0)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
