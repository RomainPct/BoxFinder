//
//  URLManager.swift
//  BoxFinder
//
//  Created by Romain Penchenat on 14/10/2021.
//

import Foundation

class URLManager {
    
    static func boxFinderPathToFinderURL(path:String) -> URL? {
        guard let dropboxURL = UserDefaults.appgroup?.url(forKey: UserDefaults.KEY.dropboxFolderURL) else { return nil }
        var dropboxEndPath = path.removingPercentEncoding ?? ""
        dropboxEndPath.removeFirst(17)
        return URL(fileURLWithPath: "\(dropboxURL.path)/\(dropboxEndPath)")
    }
    
}
