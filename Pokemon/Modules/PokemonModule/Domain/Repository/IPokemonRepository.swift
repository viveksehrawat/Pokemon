//
//  IPokemonRepository.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import Foundation

protocol IPokemonRepository {
    func fetchPokemonsFromNetwork() async throws ->  PokemonPage
}
