//
//  ShareViewController.swift
//  BoxFinder Link
//
//  Created by Romain Penchenat on 21/10/2021.
//

import Cocoa
import SwiftUI

class ShareViewController: NSViewController {
    
    private var ui_shareView:ShareView? = nil
    private var message:String = "Error"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui_shareView = ShareView(closeAction: cancel, getMessage: { return self.message })
        let ui_swiftuiView = NSHostingView(rootView: ui_shareView)
        ui_swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(ui_swiftuiView)
        ui_swiftuiView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        ui_swiftuiView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        ui_swiftuiView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        ui_swiftuiView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    }

    override func loadView() {
        super.loadView()
        guard let dropboxFolderUrl = UserDefaults.appgroup?.url(forKey: UserDefaults.KEY.dropboxFolderURL)
            else {
                message = "Configure the app in the top bar to start using BoxFinder."
                return
            }
        
        guard
            let item = extensionContext?.inputItems.first as? NSExtensionItem,
            let itemProvider = item.attachments?.first,
            itemProvider.hasItemConformingToTypeIdentifier("public.url")
            else {
                message = "Select an item in the finder to user BoxFinder."
                return
            }
        
        itemProvider.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil) { (data, error) in
            guard let url = URL(dataRepresentation: data as! Data, relativeTo: nil) else {
                self.message = "Load item URL did fail."
                return
            }
            guard url.path.contains(dropboxFolderUrl.path) else {
                self.message = "BoxFinder is only available for dropbox documents."
                return
            }
            let sharePath = url.path.replacingOccurrences(of: dropboxFolderUrl.path, with: "").addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
            let boxfinderPath = "boxfinder://root\(sharePath)"
            NSPasteboard.general.copyBoxFinderUrl(path: boxfinderPath)
            UserDefaults.appgroup?.savePathToHistory(boxfinderPath)
            self.message = "Link copied to the clipboard"
        }
    }

    private func cancel() {
        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }

}
