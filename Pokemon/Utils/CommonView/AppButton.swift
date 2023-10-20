//
//  AppButton.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 20/10/23.
//

import SwiftUI

struct AppButton: View {
    
    let title: String
    let action: ()->Void
    
    var body: some View{
        Button{
            action()
        } label: {
            Text(title)
                .font(.system(size: 20))
                .bold()
                .frame(width: 120, height: 40)
                .background(Color("filterBackgroundColor"))
                .foregroundColor(.white)
                .cornerRadius(8)

        }
    }
}

#Preview {
    AppButton(title: "Next"){}
}
