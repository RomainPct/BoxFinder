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
        static let urlsHistory = "boxFinder-urlsHistory"
    }
    
    func savePathToHistory(_ path:String) {
        var history = self.stringArray(forKey: KEY.urlsHistory) ?? []
        history = history.filter { $0 != path }
        history.insert(path, at: 0)
        if history.count > 10 {
            _ = history.popLast()
        }
        self.set(history, forKey: KEY.urlsHistory)
    }
    
}
