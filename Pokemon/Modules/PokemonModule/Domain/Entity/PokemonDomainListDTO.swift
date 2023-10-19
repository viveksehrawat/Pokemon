//
//  Pokemon.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import Foundation

// MARK: - PokemonResponse
struct PokemonDomainListDTO {
    let next: String
    let pokemons: [Pokemon]
}

// MARK: - Result
struct Pokemon: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let url: String
}
