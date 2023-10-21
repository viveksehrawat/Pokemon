//
//  Pokemon.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import Foundation

struct PokemonPage {
    let next: String
    let pokemons: [Pokemon]
}

// MARK: - Result
struct Pokemon: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let url: String
}

// MARK: PokemonDetail

struct PokemonDetail {
    let abilities: [Ability]
    let height: Int
    let id: Int
    let name: String
    let order: Int
    let species: Species
    let imageUrl: String

    let stats: [Stat]
    let weight: Int
    let responseTypes: [PokemonResponseType]

    let types: [PokemonType]

    init(abilities: [Ability],
         height: Int,
         id: Int,
         name: String,
         order: Int,
         species: Species,
         imageUrl: String,
         stats: [Stat],
         weight: Int,
         responseTypes: [PokemonResponseType]) {
        self.abilities = abilities
        self.height = height
        self.id = id
        self.name = name
        self.order = order
        self.species = species
        self.imageUrl = imageUrl
        self.stats = stats
        self.weight = weight
        self.responseTypes = responseTypes
        self.types = self.responseTypes.map {$0.toPokemonType()}
    }
}

enum PokemonType: String, CaseIterable {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    case unknown
    case shadow
}

extension PokemonDetail {

    // MARK: - Ability
    struct Ability {
        let ability: NamedURLResource
        let isHidden: Bool
        let slot: Int
    }

    // MARK: - Species
    struct Species {
        let name: String
        let url: String
    }

    // MARK: - Common
    struct NamedURLResource {
        let name: String
        let url: String
    }

    // MARK: - Type
    struct PokemonResponseType {
        let name: String
        let url: String

        func toPokemonType() -> PokemonType {
            return PokemonType(rawValue: name) ?? .unknown
        }
    }

    // MARK: - Sprites
    struct Sprites {

        struct Other {
            let officialArtwork: OfficialArtwork

            enum CodingKeys: String, CodingKey {
                case officialArtwork = "official-artwork"
            }
        }

        let other: Other?
    }

    // MARK: - OfficialArtwork
    struct OfficialArtwork {
        let frontDefault: String
    }

    // MARK: - Stat
    struct Stat {
        let baseStat, effort: Int
        let stat: NamedURLResource
    }

    // MARK: - TypeElement
    struct TypeElement {
    }

}

// MARK: - PokemonDescription
struct PokemonDescription {
    let eggGroups: [EggGroups]
    let evolutionChain: EvolutionChains
    let flavorTextEntries: [FlavorText]
    let id: Int
    let genderRate: Int

    // MARK: - eggGroups
    struct EggGroups {
        let name: String
        let url: String
    }

    // MARK: - EvolutionChain
    struct EvolutionChains {
        let url: String
    }

    // MARK: - FlavorText
    struct FlavorText {
        let flavorText: String
    }
}

struct PokemonWeakness {
    let damageRelations: DamageRelations
    let id: Int
    let name: String

    // MARK: - damageRelations
    struct DamageRelations {
        let doubleDamageFrom: [Damages]
    }

    struct Damages {
        let name: String
        let url: String
    }
}

// MARK: - EvolutionChain
struct EvolutionChain {
    let chain: Chain
    let id: Int

    // MARK: - Chain
    struct Chain {
        let evolvesTo: [Chain]
        let species: Specie
    }

    // MARK: - Species
    struct Specie {
        let name: String
        let url: String
    }
}
