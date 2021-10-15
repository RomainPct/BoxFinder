//
//  HomeTab.swift
//  BoxFinder
//
//  Created by Romain Penchenat on 14/10/2021.
//

import SwiftUI

struct HomeTab: View {
    
    @State var history:[String] = UserDefaults.appgroup?.stringArray(forKey: UserDefaults.KEY.urlsHistory) ?? []
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(history, id: \.self) { path in
                    HistoryCell(path: path)
                }
            }
        }
        .onReceive((NSApplication.shared.delegate as! AppDelegate).publisher) { _ in
            self.history = UserDefaults.appgroup?.stringArray(forKey: UserDefaults.KEY.urlsHistory) ?? []
        }
    }
    
}

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab()
    }
}
