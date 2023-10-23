//
//  PokemonDetailUseCase.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 21/10/23.
//

import Foundation



protocol IPokemonDetailUseCase {
    
    func fetchPokemonDetail(for name: String) async throws -> PokemonDetail
    func fetchPokemonDescription(for id: Int) async throws -> PokemonDescription
    func fetchPokemonWeakness(for value: Int) async throws -> PokemonWeakness
    func fetchPokemonEvolutionCahin(for url: String) async throws -> EvolutionChain
    
}
