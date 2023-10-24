//
//  ImageTextSectionView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 20/10/23.
//

import SwiftUI
import Kingfisher

struct ImageTextSectionView: View {

    let description: String
    let pokemon: PokemonDetail

    private var gradientColors: [Color] {
        let types = pokemon.types
        let name = types.map {$0.color}
        return name
    }
    
    var body: some View {
        HStack{
            
            KFImage(URL(string: pokemon.imageUrl))
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundColor(.black)
                )
                .addGradient(colors: gradientColors)
                .cornerRadius(12)
            
            Spacer(minLength: 10)
            Text(description)
                .font(.system(size: 18))
                .setForegroundColor()
                .lineLimit(10)
        }
        .frame(height: 200)
    }
}

//#Preview {
//    ImageTextSectionView()
//}
