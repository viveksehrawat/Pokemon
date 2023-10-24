//
//  IPokemonDetailUseCaseImpl.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 21/10/23.
//

import Foundation


class PokemonDetailUseCaseImpl: IPokemonDetailUseCase {
   
    private let pokemonDetailRepository: IPokemonDetailRepository

    init( pokemonDetailRepository: IPokemonDetailRepository) {
        self.pokemonDetailRepository = pokemonDetailRepository
    }
    
    func fetchPokemonDetail(for name: String) async throws -> PokemonDetail{
        let pokemonDetail = try await self.pokemonDetailRepository.fetchPokemonDetail(for: name)
        return pokemonDetail
    }
    
    func fetchPokemonDescription(for id: Int) async throws -> PokemonDescription{
        let pokemonDesc = try await self.pokemonDetailRepository.fetchPokemonDescription(for: id)
        return pokemonDesc
    }
    
    func fetchPokemonWeakness(for value: Int) async throws -> PokemonWeakness{
        let pokemonWeakness = try await self.pokemonDetailRepository.fetchPokemonWeakness(for: value)
        return pokemonWeakness
    }
    func fetchPokemonEvolutionChain(for url: String) async throws -> EvolutionChain{
        let evolution = try await self.pokemonDetailRepository.fetchPokemonEvolutionChain(for: url)
        return evolution
    }

}
