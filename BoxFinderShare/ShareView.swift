//
//  ShareView.swift
//  BoxFinder
//
//  Created by Romain Penchenat on 11/10/2021.
//

import SwiftUI

struct ShareView: View {
    
    var closeAction: () -> Void
    var getMessage: () -> String
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(getMessage())
            RowButton(text: "Close", action: closeAction, centered: true)
        }
        .foregroundColor(Color.bfText)
        .padding(.all, 24)
        .background(Color.bfZ0.edgesIgnoringSafeArea(.all))
        .onAppear {
            if getMessage() == "Link copied to the clipboard" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    closeAction()
                }
            }
        }
    }
    
}

struct ShareView_Previews: PreviewProvider {
    
    @State static var message = "Error"
    
    static var previews: some View {
        ShareView(closeAction: {
            print("Hoy close !")
        }, getMessage: { return "Message" })
    }
}
