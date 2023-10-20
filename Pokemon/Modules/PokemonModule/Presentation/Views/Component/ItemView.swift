//
//  ItemView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 20/10/23.
//

import SwiftUI

struct ItemView: View {
    
    let title: String
    let subTitle: String

    var body: some View {
        VStack{
            Text(title)
                .font(.system(size: 15))
                .bold()
            Text(subTitle)
                .font(.system(size: 13))

        }
    }
}

#Preview {
    ItemView(title: "Height", subTitle: "5'7")
}
