//
//  PokemonDetailMockData.swift
//  PokemonTests
//
//  Created by Vivek Sehrawat on 24/10/23.
//

import Foundation
@testable import Pokemon

class PokemonDetailMockData {
    
    static var domainPokemonDetail: PokemonDetail {
        return pokemonDetail.toDomain()
    }
      
    static var pokemonDetail: PokemonDetailDTO {
        pokemonDetailResponse
    }
    
    static var pokemonDetailResponse: PokemonDetailDTO {
        let response = try! JSONDecoder().decode(PokemonDetailDTO.self, from: pokemonDetailData)
        return response
    }
   
    static var pokemonDetailData: Data {
        JsonReader.loadJsonData("PokemonDetail")
    }

}
