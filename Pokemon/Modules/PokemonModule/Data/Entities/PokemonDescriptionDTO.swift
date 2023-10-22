//
//  PokemonDes.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 22/10/23.
//

import Foundation

// MARK: - PokemonDescription
struct PokemonDescriptionDTO: Decodable {
    
    let id: Int
    let genderRate: Int
    let eggGroups: [EggGroups]
    let evolutionChain: EvolutionChains
    let flavorTextEntries: [FlavorText]
    
    enum CodingKeys: String, CodingKey {
        case eggGroups = "egg_groups"
        case evolutionChain = "evolution_chain"
        case flavorTextEntries = "flavor_text_entries"
        case genderRate = "gender_rate"
        case id
    }

    // MARK: - eggGroups
    struct EggGroups: Codable {
        let name: String
        let url: String

        func toDomain() -> PokemonDescription.EggGroups {
            return .init(name: name, url: url)
        }
    }

    // MARK: - EvolutionChain
    struct EvolutionChains: Codable {
        let url: String

        func toDomain() -> PokemonDescription.EvolutionChains {
            return .init(url: url)
        }
    }

    // MARK: - FlavorText
    struct FlavorText: Codable {
        let flavorText: String
        
        enum CodingKeys: String, CodingKey {
            case flavorText = "flavor_text"
        }

        func toDomain() -> PokemonDescription.FlavorText {
            return .init(flavorText: flavorText)
        }
    }

    func toDomain() -> PokemonDescription {

        .init(eggGroups: eggGroups.map {$0.toDomain()},
              evolutionChain: evolutionChain.toDomain(),
              flavorTextEntries: flavorTextEntries.map {$0.toDomain()},
              id: id,
              genderRate: genderRate)
    }
}
