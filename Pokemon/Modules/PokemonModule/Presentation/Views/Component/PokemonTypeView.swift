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
    var type: PokemonType = PokemonType.electric
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .overlay(
                Text("")
            )

    }
}

#Preview {
    PokemonTypes()
}
