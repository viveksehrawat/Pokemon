//
//  IPokemonUseCase.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import Foundation

protocol IPokemonUseCase {
    func fetchPokemonData() async throws -> [Pokemon]
}
