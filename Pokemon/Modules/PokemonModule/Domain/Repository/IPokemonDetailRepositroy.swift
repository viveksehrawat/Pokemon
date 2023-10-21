//
//  IPokemonDetailRepositroy.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 21/10/23.
//

import Foundation
protocol IPokemonDetailRepository {
    
    func fetchPokemonDetail(for name: String) async throws -> PokemonDetail
    func fetchPokemonDescription(for id: String) async throws -> PokemonDescription
    func fetchPokemonWeakness(for id: String) async throws -> PokemonWeakness
    func fetchPokemonEvolutionCahin(for url: String) async throws -> PokemonWeakness
    
}
