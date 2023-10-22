//
//  IPokemonDetailRepositroy.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 21/10/23.
//

import Foundation
protocol IPokemonDetailRepository {
    
    func fetchPokemonDetail(for name: Int) async throws -> PokemonDetail
    func fetchPokemonDescription(for id: Int) async throws -> PokemonDescription
    func fetchPokemonWeakness(for value: Int) async throws -> PokemonWeakness
//    func fetchPokemonEvolutionChain(for url: String) async throws -> PokemonWeakness
    
}
