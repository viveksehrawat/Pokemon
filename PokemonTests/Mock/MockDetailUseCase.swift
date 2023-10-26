//
//  MockDetailUseCase.swift
//  PokemonTests
//
//  Created by Vivek Sehrawat on 26/10/23.
//

import Foundation

@testable import Pokemon

class MockDetailUseCase: IPokemonDetailUseCase {
    
    var detail: PokemonDetail?
    var pokemonDescription: PokemonDescription?
    var pokemonWeakness: PokemonWeakness?
    var evolutionChain: EvolutionChain?
    var error: Error?

    func fetchPokemonDescription(for id: Int) async throws -> PokemonDescription{
        if let error = error {
            throw error
        }
        if let pokemonDescription = pokemonDescription {
            return pokemonDescription
        }
        
        fatalError("You must set either 'pokemonDescription' or 'error' to control the behavior of the mock.")
    }
    
    func fetchPokemonWeakness(for value: Int) async throws -> PokemonWeakness{
        if let error = error {
            throw error
        }
        if let pokemonWeakness = pokemonWeakness {
            return pokemonWeakness
        }
        
        fatalError("You must set either 'pokemonWeakness' or 'error' to control the behavior of the mock.")
        

    }
    
    func fetchPokemonEvolutionChain(for url: String) async throws -> EvolutionChain{
       
        if let error = error {
            throw error
        }
        if let evolutionChain = evolutionChain {
            return evolutionChain
        }
        
        fatalError("You must set either 'evolutionChain' or 'error' to control the behavior of the mock.")

    }
 
    func fetchPokemonDetail(for name: String) async throws -> PokemonDetail{
       
        if let error = error {
            throw error
        }
        if let detail = detail {
            return detail
        }
        
        fatalError("You must set either 'detail' or 'error' to control the behavior of the mock.")
    }
    
}
