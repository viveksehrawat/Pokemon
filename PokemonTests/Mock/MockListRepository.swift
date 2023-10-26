//
//  MockListRepository.swift
//  PokemonTests
//
//  Created by Vivek Sehrawat on 26/10/23.
//

import Foundation
@testable import Pokemon


class MockPokemonRepository: IPokemonRepository {
    
    var page: PokemonPage?
    var error: Error?
    
    func fetchPokemonsFromNetwork() async throws -> PokemonPage {
        if let error = error {
            throw error
        }
        if let page = page {
            return page
        }
        
        fatalError("You must set either 'page' or 'error' to control the behavior of the mock.")
    }
}


