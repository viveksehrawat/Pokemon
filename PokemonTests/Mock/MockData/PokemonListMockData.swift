//
//  MockData.swift
//  PokemonTests
//
//  Created by Vivek Sehrawat on 24/10/23.
//

import Foundation

@testable import Pokemon

class PokemonListMockData {
    
    static var pokemons: [PokemonDTO] {
        pokemonResponse.results
    }
    
    static var pokemonResponse: PokemonListDTO {
        let response = try! JSONDecoder().decode(PokemonListDTO.self, from: pokemonData)
        return response
    }
    
    static var domainPokemon: [Pokemon] {
        return pokemons.map { $0.toDomain() }
    }
        
    static var pokemonData: Data {
        JsonReader.loadJsonData("PokemonList")
    }

}
