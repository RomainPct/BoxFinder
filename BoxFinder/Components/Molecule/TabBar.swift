//
//  TabBar.swift
//  BoxFinder
//
//  Created by Romain Penchenat on 14/10/2021.
//

import SwiftUI

struct TabBar: View {
    
    @Binding var tabIndex:Int
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            TabButton(text: "History", index: 0, selectedIndex: $tabIndex)
            TabButton(text: "Settings", index: 1, selectedIndex: $tabIndex)
            Spacer()
        }
        .padding(.horizontal, 8)
        .background(Color.bfZ1)
    }
}

struct TabBar_Previews: PreviewProvider {
    
    @State static var tabIndex = 0
    
    static var previews: some View {
        TabBar(tabIndex: $tabIndex)
    }
}
