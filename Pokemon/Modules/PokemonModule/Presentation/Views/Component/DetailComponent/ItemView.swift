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
        VStack(alignment: .leading){
            Text(title)
                .font(.system(size: 18))
                .bold()
            Spacer(minLength: 10)
            Text(subTitle)
                .font(.system(size: 15))

        }
    }
}

#Preview {
    ItemView(title: "Height", subTitle: "5'7")
}
