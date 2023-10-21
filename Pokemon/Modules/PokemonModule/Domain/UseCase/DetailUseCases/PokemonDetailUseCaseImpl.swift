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
    
    func fetchPokemonDetail(for index: String) async throws -> PokemonDetail{
        let pokemonDetail = try await self.pokemonDetailRepository.fetchPokemonDetail(for: index)
        return pokemonDetail
    }

}
