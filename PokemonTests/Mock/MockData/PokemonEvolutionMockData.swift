//
//  PokemonEvolMockData.swift
//  PokemonTests
//
//  Created by Vivek Sehrawat on 24/10/23.
//

import Foundation
@testable import Pokemon

class PokemonEvolutionMockData {
    
    static var domainPokemonEvolution: EvolutionChain {
        return pokemonEvolution.toDomain()
    }
    
    static var pokemonEvolution: EvolutionChainDTO {
        pokemonEvolutionResponse
    }
    
    static var pokemonEvolutionResponse: EvolutionChainDTO {
        let response = try! JSONDecoder().decode(EvolutionChainDTO.self, from: pokemonEvolutionData)
        return response
    }
    
    static var pokemonEvolutionData: Data {
        JsonReader.loadJsonData("PokemonEvolution")
    }

}
