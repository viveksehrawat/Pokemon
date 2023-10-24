//
//  PokemonDescMockData.swift
//  PokemonTests
//
//  Created by Vivek Sehrawat on 24/10/23.
//

import Foundation

@testable import Pokemon

class PokemonDescMockData {
    
    static var domainPokemonDesc: PokemonDescription {
        return pokemonDesc.toDomain()
    }
    
    static var pokemonDesc: PokemonDescriptionDTO {
        pokemonDescResponse
    }
    
    static var pokemonDescResponse: PokemonDescriptionDTO {
        let response = try! JSONDecoder().decode(PokemonDescriptionDTO.self, from: pokemonDescData)
        return response
    }
    
    static var pokemonDescData: Data {
        JsonReader.loadJsonData("PokemonDescription")
    }

}
