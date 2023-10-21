//
//  PokemonUseCaseImpl.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import Foundation

class PokemonListUseCaseImpl: IPokemonListUseCase {
    
    private let respository: IPokemonRepository
    private let pokemonDetailRepository: IPokemonDetailRepository

    init(respository: IPokemonRepository, pokemonDetailRepository: IPokemonDetailRepository) {
        self.respository = respository
        self.pokemonDetailRepository = pokemonDetailRepository
    }
    
    func fetchPokemonList() async throws -> PokemonPage {
        let pokemonData = try await self.respository.fetchPokemonsFromNetwork()
        return pokemonData
    }
    
    func fetchPokemonDetail(for name: String) async throws -> PokemonDetail{
        let pokemonDetail = try await self.pokemonDetailRepository.fetchPokemonDetail(for: name)
        return pokemonDetail
    }

}
