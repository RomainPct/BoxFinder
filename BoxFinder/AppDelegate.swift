//
//  AppDelegate.swift
//  BoxFinder
//
//  Created by Romain Penchenat on 09/10/2021.
//

import Foundation
import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var error:String? = nil
    
    private var popover: NSPopover!
    private lazy var contentView = ContentView()
    private var statusBarItem: NSStatusItem!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let em = NSAppleEventManager.shared()
        em.setEventHandler(self, andSelector: #selector(self.getUrl(_:withReplyEvent:)), forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))

        // Create the popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 320, height: 518)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        self.popover = popover
        
        // Create the status item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        
        if let button = self.statusBarItem.button {
            button.image = NSImage(named: "Icon")
            button.action = #selector(togglePopover(_:))
        }
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            popover.performClose(sender)
        } else {
            openPopover()
        }
    }
    
    private func openPopover() {
        guard let button = self.statusBarItem.button else { return }
        self.popover.show(relativeTo: button.frame, of: button, preferredEdge: NSRectEdge.minY)
        self.popover.contentViewController?.view.window?.becomeKey()
    }

    @objc func getUrl(_ event: NSAppleEventDescriptor, withReplyEvent replyEvent: NSAppleEventDescriptor) {
        let urlStr: String = event.paramDescriptor(forKeyword: keyDirectObject)!.stringValue!
        openInFinder(path: urlStr)
    }
    
    func openInFinder(path:String) {
        guard let dropboxURL = UserDefaults.appgroup?.url(forKey: UserDefaults.KEY.dropboxFolderURL) else {
            error = "Dropbox URL not configured"
            openPopover()
            return
        }
        var dropboxEndPath = path.removingPercentEncoding ?? ""
        dropboxEndPath.removeFirst(17)
        UserDefaults.appgroup?.savePathToHistory(path)
        let finderURL = URL(fileURLWithPath: "\(dropboxURL.path)/\(dropboxEndPath)")
        if finderURL.isFileURL {
            NSWorkspace.shared.activateFileViewerSelecting([finderURL])
        } else {
            NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: finderURL.path)
        }
    }
    
}
