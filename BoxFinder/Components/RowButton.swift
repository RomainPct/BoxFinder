//
//  RowButton.swift
//  BoxFinder
//
//  Created by Romain Penchenat on 09/10/2021.
//

import SwiftUI

struct RowButton: View {
    
    var text:String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .center) {
                Text(text)
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding(.all, 8)
            .background(Color.black)
            .cornerRadius(4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct RowButton_Previews: PreviewProvider {
    static var previews: some View {
        RowButton(text: "Demo") {
            print("hey")
        }
    }
}
