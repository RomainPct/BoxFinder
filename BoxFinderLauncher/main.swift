//
//  main.swift
//  BoxFinderLauncher
//
//  Created by Romain Penchenat on 15/10/2021.
//

import Cocoa

let delegate = LauncherAppDelegate()
NSApplication.shared.delegate = delegate
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
