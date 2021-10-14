//
//  NSPasteboard_extension.swift
//  BoxFinder
//
//  Created by Romain Penchenat on 14/10/2021.
//

import Foundation
import AppKit

extension NSPasteboard {
    
    func copyBoxFinderUrl(path:String) {
        self.declareTypes([.string, .URL], owner: nil)
        self.setString(path, forType: .string)
        self.setString(path, forType: .URL)
    }
    
}
