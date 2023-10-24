//
//  WeakAgainstView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 22/10/23.
//

import SwiftUI

struct QualityView: View {
    
    let title: String
    let data: [String]

    var body: some View {
        
        VStack(alignment: .leading){
            Text(title)
                .font(.system(size: 18))
                .setForegroundColor()
                .bold()
//            Spacer(minLength: 30)
            LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                ForEach(data, id: \.self) { type in
                    PokemonCapsuleView(type: PokemonType(rawValue: type) ?? .fire)
                }
            }
        }
    }
}
