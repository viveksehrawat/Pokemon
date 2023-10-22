//
//  EvolutionChainDTO.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 22/10/23.
//

import Foundation

// MARK: - EvolutionChain
struct EvolutionChainDTO: Decodable {
    let chain: Chain
    let id: Int

    func toDomain() -> EvolutionChain {
        .init(chain: chain.toDomain(),
              id: id)
    }

    // MARK: - Chain
    struct Chain: Codable {
        let evolvesTo: [Chain]
        let species: Specie

        private enum Codingkeys: String, CodingKey {
            case evolvesTo = "evolves_to"
        }

        func toDomain() -> EvolutionChain.Chain {
            .init(evolvesTo: evolvesTo.map {$0.toDomain()},
                  species: species.toDomain())
        }
    }

    // MARK: - Species
    struct Specie: Codable {
        let name: String
        let url: String

        func toDomain() -> EvolutionChain.Specie {
            .init(name: name,
                  url: url)
        }
    }
}
