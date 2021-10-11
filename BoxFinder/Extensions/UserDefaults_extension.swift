//
//  Shared.swift
//  BoxFinder
//
//  Created by Romain Penchenat on 09/10/2021.
//

import Foundation

extension UserDefaults {
    
    static var appgroup: UserDefaults? { UserDefaults(suiteName: "AU9T7HA2AB.boxfinder.app") }
    
    struct KEY {
        static let dropboxFolderURL = "boxFinder-dropboxFolderURL"
    }
    
}
