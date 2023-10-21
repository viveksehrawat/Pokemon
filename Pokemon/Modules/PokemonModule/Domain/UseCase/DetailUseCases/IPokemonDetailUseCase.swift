//
//  PokemonDetailUseCase.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 21/10/23.
//

import Foundation



protocol IPokemonDetailUseCase {
    
    func fetchPokemonDetail(for index: String) async throws -> PokemonDetail
//    func fetchPokemonDescription(for id: String) async throws -> PokemonDescription
//    func fetchPokemonWeakness(for id: String) async throws -> PokemonWeakness
//    func fetchPokemonEvolutionCahin(for url: String) async throws -> PokemonWeakness
    
}
