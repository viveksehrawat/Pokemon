//
//  IPokemonUseCase.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import Foundation

protocol IPokemonListUseCase {
    func fetchPokemonList() async throws -> PokemonPage
    func fetchPokemonDetail(for id: Int) async throws -> PokemonDetail

}
