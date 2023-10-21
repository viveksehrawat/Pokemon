//
//  HeaderView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 20/10/23.
//

import SwiftUI

struct HeaderView: View {

    var dismiss: ()-> Void
    var title: String
    var number: String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(title)
                    .font(.system(size: 40))
                    .bold()
                Text(number)
                    .font(.system(size: 25))
                
            }
//            .padding(.top, 10)
            Spacer()
            Button{
                dismiss()
            }label: {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    HeaderView(dismiss: {

    }, title: "Pokemon", number: "007")
}
