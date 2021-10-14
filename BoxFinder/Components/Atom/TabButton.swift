//
//  TabButton.swift
//  BoxFinder
//
//  Created by Romain Penchenat on 14/10/2021.
//

import SwiftUI

struct TabButton: View {
    
    var text:String
    var index:Int
    @Binding var selectedIndex:Int
    
    private var isSelected: Bool { index == selectedIndex }
    
    var body: some View {
        Text(text)
            .font(Font.system(size: 12, weight: .bold))
            .foregroundColor(Color.bfText)
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 10)
            .background(Color.bfZ1)
            .overlay(
                Rectangle()
                    .fill(Color.bfText)
                    .frame(height: 2)
                    .opacity(isSelected ? 1 : 0),
                alignment: .bottom
            )
            .onTapGesture {
                selectedIndex = index
            }
    }
    
}

struct TabButton_Previews: PreviewProvider {
    
    @State static var selectedIndex:Int = 0
    
    static var previews: some View {
        TabButton(text: "Home", index: 0, selectedIndex: $selectedIndex)
    }
}
