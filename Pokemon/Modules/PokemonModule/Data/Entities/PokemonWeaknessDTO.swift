//
//  PokemonWeaknessDTO.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 22/10/23.
//

import Foundation

struct PokemonWeaknessDTO: Decodable {
    let damageRelations: DamageRelations
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case damageRelations = "damage_relations"
        case id, name
    }

    func toDomain() -> PokemonWeakness {
        .init(damageRelations: damageRelations.toDomain(),
              id: id,
              name: name)
    }

    // MARK: - damageRelations
    struct DamageRelations: Decodable {
        let doubleDamageFrom: [Damages]
        enum CodingKeys: String, CodingKey {
            case doubleDamageFrom = "double_damage_from"
        }
        func toDomain() -> PokemonWeakness.DamageRelations {
            .init(doubleDamageFrom: doubleDamageFrom.map {$0.toDomain()})
        }
    }

    struct Damages: Decodable {
        let name: String
        let url: String
        func toDomain() -> PokemonWeakness.Damages {
            .init(name: name, url: url)
        }
    }
}
