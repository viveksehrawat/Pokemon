//
//  IPokemonService.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import Foundation

protocol IPokemonService{
    func fetchPokemonsFromNetwork() async throws -> PokemonResponse
}
