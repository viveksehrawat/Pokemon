//
//  PokemonRepository.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import Foundation

class PokemonRepositoryImpl: IPokemonRepository {
   
    private let service: IPokemonService
    init(service: IPokemonService) {
        self.service = service
    }
    
    func fetchPokemonList() async throws ->  PokemonDomainListDTO {
        let response = try await self.service.fetchPokemonsFromNetwork()
        return response.toDomain()
    }
    
}
