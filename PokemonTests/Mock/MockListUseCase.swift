//
//  MockListUseCase.swift
//  PokemonTests
//
//  Created by Vivek Sehrawat on 26/10/23.
//

import Foundation
@testable import Pokemon

class MockListUseCase: IPokemonListUseCase {
    
    var page: PokemonPage?
    var detail: PokemonDetail?
    var error: Error?
    
    func fetchPokemonList() async throws -> PokemonPage{
        if let error = error {
            throw error
        }
        if let page = page {
            return page
        }
        
        fatalError("You must set either 'page' or 'error' to control the behavior of the mock.")
    }
    
    func fetchPokemonDetail(for name: String) async throws -> PokemonDetail{
        if let error = error {
            throw error
        }
        if let detail = detail {
            return detail
        }
        
        fatalError("You must set either 'detail' or 'error' to control the behavior of the mock.")

    }
    
}
