//
//  AutoLauncherAppDelegate.swift
//  BoxFinderLauncher
//
//  Created by Romain Penchenat on 15/10/2021.
//

import Cocoa

class LauncherAppDelegate: NSObject, NSApplicationDelegate {
    
    private let mainAppID = "com.romainpenchenat.BoxFinder"

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        print("launch")
        // Insert code here to initialize your application
        let apps = NSWorkspace.shared.runningApplications
        let isMainAppRunning = apps.contains { $0.bundleIdentifier == mainAppID }
        print(apps)
        print(isMainAppRunning)
        if !isMainAppRunning {
            var path = Bundle.main.bundlePath as NSString
            print(path)
            for _ in 1...3 {
                path = path.deletingLastPathComponent as NSString
            }
            let appPath = "\(path)/MacOS/BoxFinder"
            let alert = NSAlert()
            alert.messageText = appPath
            alert.alertStyle = .warning
            alert.addButton(withTitle: "OK")
            alert.runModal()
            
            guard let appUrl = URL(string: appPath) else { return }
            NSWorkspace.shared.openApplication(at: appUrl, configuration: NSWorkspace.OpenConfiguration()) { app, error in
                print(app, error)
            }
        }
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

