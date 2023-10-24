//
//  PokemonWeaknessMockData.swift
//  PokemonTests
//
//  Created by Vivek Sehrawat on 24/10/23.
//

import Foundation
@testable import Pokemon

class PokemonWeaknessMockData {
    
    static var domainPokemonWeakness: PokemonWeakness {
        return pokemonWeakness.toDomain()
    }
    
    static var pokemonWeakness: PokemonWeaknessDTO {
        pokemonWeaknessResponse
    }
    
    static var pokemonWeaknessResponse: PokemonWeaknessDTO {
        let response = try! JSONDecoder().decode(PokemonWeaknessDTO.self, from: pokemonWeaknessData)
        return response
    }
    
    static var pokemonWeaknessData: Data {
        JsonReader.loadJsonData("PokemonWeakness")
    }

}
