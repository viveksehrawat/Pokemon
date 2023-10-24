//
//  PokemonCellView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import SwiftUI
import Kingfisher



struct PokemonCellView: View {
    
    let pokemon: PokemonDetail
    let index: Int
    
    private var gradientColors: [Color] {
        let types = pokemon.types
        let name = types.map {$0.color}
        return name
    }
    
    var body: some View {
        
        VStack {
            
            KFImage(URL(string: pokemon.imageUrl)!)
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
                .padding()
            Text(pokemon.name.capitalized)
                .font(.system(size: 18))
                .foregroundColor(.black)
                .bold()
            Text(String(format: "%03d", pokemon.id))
                .font(.system(size: 15))
                .foregroundColor(.black)
            
        }
        .frame(height: 250)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                .foregroundColor(.black)
        )
        .addGradient(colors: gradientColors)
        .cornerRadius(12)
    }
}

//#Preview {
//    let pokemon = Pokemon(name: "Vivek", url: "")
//    PokemonCellView(pokemon: pokemon)
//}
