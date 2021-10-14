//
//  IconButton.swift
//  BoxFinder
//
//  Created by Romain Penchenat on 14/10/2021.
//

import SwiftUI

struct IconButton: View {
    
    var action:() -> Void
    var imageName:String
    
    var body: some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(Color.bfText)
        }
        .frame(width: 40, height: 40)
        .buttonStyle(PlainButtonStyle())
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(action: {}, imageName: "Icon")
    }
}
