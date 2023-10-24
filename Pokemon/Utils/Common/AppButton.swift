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
            HStack(alignment: .center ) {
                if !isNextButton {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .font(.system(size: 17))
                }
                Text(title)
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                if isNextButton {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        .font(.system(size: 17))
                }
            }
            .frame(width: 140, height: 40)
            .background(Color("filterBackgroundColor"))
            .cornerRadius(8)
        }
    }
}

//#Preview {
//    AppButton(title: "Next"){}
//}
