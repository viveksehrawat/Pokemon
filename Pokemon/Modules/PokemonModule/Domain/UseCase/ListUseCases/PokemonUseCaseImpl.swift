//
//  PokemonUseCaseImpl.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import Foundation

class PokemonUseCaseImpl: IPokemonUseCase {
    
    private let respository: IPokemonRepository
   
    init(respository: IPokemonRepository) {
        self.respository = respository
    }
    
    func fetchPokemonData() async throws -> [Pokemon] {
        let pokemonData = try await self.respository.fetchPokemonsFromNetwork()
        return pokemonData.pokemons
    }
}
