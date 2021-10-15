//
//  SettingsTab.swift
//  BoxFinder
//
//  Created by Romain Penchenat on 14/10/2021.
//

import SwiftUI
import ServiceManagement

struct SettingsTab: View {
    
    @State var dropboxFolder:URL? = UserDefaults.appgroup?.url(forKey: UserDefaults.KEY.dropboxFolderURL)
    
    @State var launchAtLogin:Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Select your dropbox root folder in order to allow BoxFinder to create and open direct link to dropbox files.")
                    .font(.body)
                Text("Current folder : \(dropboxFolder?.path ?? "unknown")")
                    .font(.caption)
                RowButton(text: "Change dropbox root folder", action: pickDropboxRootAction)
            }
            .padding(.horizontal, 16)
            /*
            Toggle(isOn: $launchAtLogin) {
                Text("Launch at login")
                    .font(.body)
            }
            .padding(.horizontal, 16)
            .onChange(of: launchAtLogin) { launchAtLogin in
                SMLoginItemSetEnabled("com.romainpenchenat.BoxFinderLauncher" as CFString, launchAtLogin)
            }
             */
            HStack(alignment: .center, spacing: 8) {
//                RowButton(text: "Share the app", action: shareAction)
//                RowButton(text: "Contact developers", action: contactAction)
                RowButton(text: "Quit BoxFinder", action: exitAction)
            }
            .padding(.horizontal, 16)
        }
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
        
        folderPicker.begin { response in
            folderPickerDidEnd(picker: folderPicker, response: response)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            folderPicker.close()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                folderPicker.begin { response in
                    folderPickerDidEnd(picker: folderPicker, response: response)
                }
                folderPicker.orderFrontRegardless()
            }
        }
    }
    
    func folderPickerDidEnd(picker:NSOpenPanel, response:NSApplication.ModalResponse) {
        guard response == .OK else { return }
        guard let folder = picker.url else { return }
        dropboxFolder = folder
        UserDefaults.appgroup?.set(folder, forKey: UserDefaults.KEY.dropboxFolderURL)
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

struct SettingsTab_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTab()
    }
}
