//
//  AppButton.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 20/10/23.
//

import SwiftUI

struct AppButton: View {
    
    let title: String
    let isNextButton: Bool
    let action: ()->Void
    
    var body: some View{
        
        Button{
            action()
        } label: {
            HStack {
                if !isNextButton {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
                Text(title)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                if isNextButton {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
            }
            .frame(width: 130, height: 40)
            .background(Color("filterBackgroundColor"))
            .cornerRadius(8)
        }
    }
}

//#Preview {
//    AppButton(title: "Next"){}
//}
