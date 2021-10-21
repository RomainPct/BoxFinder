//
//  ContentView.swift
//  BoxFinder
//
//  Created by Romain Penchenat on 09/10/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var tabIndex = UserDefaults.appgroup?.object(forKey: UserDefaults.KEY.dropboxFolderURL) == nil ? 1 : 0
    @State var error:String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("BoxFinder v0.4")
                    .font(.title2)
                Spacer()
            }
            .padding(EdgeInsets(top: 24, leading: 24, bottom: 16, trailing: 24))
            .background(Color.bfZ1)
            TabBar(tabIndex: $tabIndex)
                .padding(.bottom, 16)
            switch tabIndex {
                case 1:
                    SettingsTab()
                default:
                    HomeTab()
            }
            Spacer()
        }
        .padding(.bottom, 16)
        .foregroundColor(Color.bfText)
        .background(Color.bfZ0)
        .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification)) { _ in
            showError()
        }
        .onAppear(perform: showError)
    }
    
    func showError() {
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else { return }
        if appDelegate.error != nil {
            tabIndex = 1
        }
        self.error = appDelegate.error
        appDelegate.error = nil
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
