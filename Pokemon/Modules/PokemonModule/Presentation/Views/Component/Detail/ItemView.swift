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
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 18))
                .setForegroundColor()
                .bold()
            
            Text(subTitle)
                .font(.system(size: 15))
                .setForegroundColor()


        }
    }
}

#Preview {
    ItemView(title: "Height", subTitle: "5'7")
}
