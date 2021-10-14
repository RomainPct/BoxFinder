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
            HStack {
                Text("BoxFinder v0.2")
                    .font(.headline)
                Spacer()
            }
            .padding(.all, 16)
            .background(Color.bfZ1)
            VStack(alignment: .leading, spacing: 8) {
                Text("Select your dropbox root folder in order to allow BoxFinder to create and open direct link to dropbox files.")
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(6)
                Text("Current folder : \(dropboxFolder?.path ?? "unknown")")
                    .font(.caption)
                RowButton(text: "Change dropbox root folder", action: pickDropboxRootAction)
            }
            .padding(.horizontal, 16)
            HStack(alignment: .center, spacing: 8) {
//                RowButton(text: "Share the app", action: shareAction)
//                RowButton(text: "Contact developers", action: contactAction)
                RowButton(text: "Quit BoxFinder", action: exitAction)
            }
            .padding(.horizontal, 16)
        }
        .padding(.bottom, 16)
        .foregroundColor(Color.bfText)
        .background(Color.bfZ0)
    }
    
    private func pickDropboxRootAction() {
        let folderChooserPoint = CGPoint(x: 0, y: 0)
        let folderChooserSize = CGSize(width: 500, height: 600)
        let folderChooserRectangle = CGRect(origin: folderChooserPoint, size: folderChooserSize)
        let folderPicker = NSOpenPanel(contentRect: folderChooserRectangle, styleMask: .utilityWindow, backing: .buffered, defer: true)

        folderPicker.allowsMultipleSelection = false
        folderPicker.canChooseDirectories = true
        folderPicker.canChooseFiles = false
        folderPicker.canDownloadUbiquitousContents = true
        folderPicker.canResolveUbiquitousConflicts = true
        
        folderPicker.begin { _ in }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            folderPicker.close()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                folderPicker.begin { response in
                    guard response == .OK else { return }
                    guard let folder = folderPicker.url else { return }
                    dropboxFolder = folder
                    UserDefaults.appgroup?.set(folder, forKey: UserDefaults.KEY.dropboxFolderURL)
                }
                folderPicker.orderFrontRegardless()
            }
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
