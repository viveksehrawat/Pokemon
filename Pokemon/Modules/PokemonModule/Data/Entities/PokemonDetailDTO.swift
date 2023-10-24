//
//  PokemonDetail.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 21/10/23.
//

import Foundation

struct PokemonDetailDTO: Decodable {
    
    let abilities: [Ability]
    let height: Int
    let id: Int
    let name: String
    let order: Int
    let species: Species
    let sprites: Sprites
    let stats: [Stat]
    let weight: Int
    let types: [TypeElement]
    
    
    func toDomain() -> PokemonDetail {
        return PokemonDetail.init(
            abilities: abilities.map {$0.toDomain()},
            height: height,
            id: id,
            name: name,
            order: order,
            species: species.toDomain(),
            imageUrl: sprites.thumbnail ?? "",
            stats: stats.map {$0.toDomain()},
            weight: weight,
            responseTypes: types.map {$0.type.toDomain()}
        )
    }
    
}

extension PokemonDetailDTO {
    
    // MARK: - Ability
    struct Ability: Decodable {
        let ability: Species
        let isHidden: Bool
        let slot: Int
        
        enum CodingKeys: String, CodingKey {
            case ability
            case isHidden = "is_hidden"
            case slot
        }
        
        func toDomain() -> PokemonDetail.Ability {
            PokemonDetail.Ability.init(ability: ability.toDomain(),
                                       isHidden: isHidden,
                                       slot: slot)
        }
        
    }
    
    // MARK: - Species
    struct Species: Decodable {
        let name: String
        let url: String
        
        func toDomain() -> PokemonDetail.Species {
            return .init(name: name,
                         url: url)
        }
        
    }
    
    // MARK: - Type
    struct PokemonType: Decodable {
        let name: String
        let url: String
        
        func toDomain() -> PokemonDetail.PokemonResponseType {
            return PokemonDetail.PokemonResponseType.init(name: name, url: url)
        }
    }
    
    // MARK: - GameIndex
    struct GameIndex: Decodable {
        let gameIndex: Int

        
        enum CodingKeys: String, CodingKey {
            case gameIndex = "game_index"

        }
    }
    
    // MARK: - HeldItem
    struct HeldItem: Decodable {
        let item: Species
        let versionDetails: [VersionDetail]
    }
    
    // MARK: - VersionDetail
    struct VersionDetail: Decodable {
        let rarity: Int
        let version: Species
    }
    
    // MARK: - Move
    struct Move: Decodable {
        let move: Species
        //  let versionGroupDetails: [VersionGroupDetail]
    }
    
    // MARK: - Sprites
    class Sprites: Decodable {
        
        let other: Other?
        let thumbnail: String?
       
        enum CodingKeys: String, CodingKey {
            case thumbnail = "front_default"
            case other
        }
        
        struct Other: Decodable {
            //    let dreamWorld: DreamWorld
            //    let home: Home
            let officialArtwork: OfficialArtwork
            
            enum CodingKeys: String, CodingKey {
                //        case dreamWorld = "dream_world"
                //        case home
                case officialArtwork = "official-artwork"
            }
            
            // MARK: - OfficialArtwork
            struct OfficialArtwork: Decodable {
                let frontDefault: String
                
                enum CodingKeys: String, CodingKey {
                    case frontDefault = "front_default"
                }
            }
        }
        
    }
    
    // MARK: - GenerationI
    struct GenerationI: Decodable {
        let redBlue, yellow: RedBlue
        
        enum CodingKeys: String, CodingKey {
            case redBlue = "red-blue"
            case yellow
        }
    }
    
    // MARK: - RedBlue
    struct RedBlue: Decodable {
        let backDefault, backGray, backTransparent, frontDefault: String
        let frontGray, frontTransparent: String
    }
    
    // MARK: - GenerationIi
    struct GenerationIi: Decodable {
        let crystal: Crystal
        let gold, silver: Gold
    }
    
    // MARK: - Crystal
    struct Crystal: Decodable {
        let backDefault, backShiny, backShinyTransparent, backTransparent: String
        let frontDefault, frontShiny, frontShinyTransparent, frontTransparent: String
    }
    
    // MARK: - Gold
    struct Gold: Decodable {
        let backDefault, backShiny, frontDefault, frontShiny: String
        let frontTransparent: String?
    }
    
    // MARK: - Stat
    struct Stat: Decodable {
        let baseStat, effort: Int
        let stat: Species
        
        
        enum CodingKeys: String, CodingKey {
            case baseStat = "base_stat"
            case effort, stat
        }
        
        func toDomain() -> PokemonDetail.Stat {
            .init(baseStat: baseStat,
                  effort: effort,
                  stat: stat.toDomain())
        }
        
    }
    
    // MARK: - TypeElement
    struct TypeElement: Decodable {
        let slot: Int
        let type: PokemonType
    }
    
}
