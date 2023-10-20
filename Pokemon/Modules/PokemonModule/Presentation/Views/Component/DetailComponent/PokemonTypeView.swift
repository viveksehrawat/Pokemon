//
//  PokemonTypes.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 20/10/23.
//

import SwiftUI

enum PokemonType: String {
    case fire
    case poison
    case water
    case electric
    case psychic
    case normal
    case ground
    case flying
    case fairy
    case none
}

struct PokemonTypes: View {
    let type: PokemonType
    
    var body: some View {
        
        Text(type.rawValue.capitalized)
            .font(.system(size: 15))
            .padding(.all, 8)
            .background(Color.pokemon(type: type))
            .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.black, lineWidth: 1)
                )
            .frame(height: 20)

    }
}

#Preview {
    PokemonTypes(type: PokemonType.electric)
}
