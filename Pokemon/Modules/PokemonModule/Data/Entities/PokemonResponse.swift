//
//  PokemonApiResponse.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import Foundation

// MARK: - PokemonResponse
struct PokemonResponse: Decodable {
    let next: String
    let results: [PokemonDataListDTO]

    func toDomain() -> PokemonDomainListDTO {
        return .init(next: next, pokemons: results.map { $0.toDomain() })
    }
}

// MARK: - Result
struct PokemonDataListDTO: Decodable {
    let name: String
    let url: String

    func toDomain() -> Pokemon {
        return .init(name: name, url: url)
    }
}

