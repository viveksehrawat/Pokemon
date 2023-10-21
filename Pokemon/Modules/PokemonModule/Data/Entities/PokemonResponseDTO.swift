//
//  PokemonApiResponse.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import Foundation

// MARK: - PokemonResponse
struct PokemonResponseDTO: Decodable {
    let next: String
    let results: [PokemonDTO]

    func toDomain() -> PokemonPage {
        return .init(next: next, pokemons: results.map { $0.toDomain() })
    }
}

// MARK: - Result
struct PokemonDTO: Decodable {
    let name: String
    let url: String

    func toDomain() -> Pokemon {
        return .init(name: name, url: url)
    }
}

