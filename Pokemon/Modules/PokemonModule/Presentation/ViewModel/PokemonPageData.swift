//
//  PokemonPageData.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 24/10/23.
//

import Foundation
import UIKit
import SwiftUI

class PokemonDetailData {
     var pokemonDetail: PokemonDetail?
     var pokemonDescription: PokemonDescription?
     var pokemonWeakness: PokemonWeakness?
     var pokemonEvolutionChain: EvolutionChain?
     var detailImage: UIImage =  UIImage()
     var evolutionChainDetails: [EvolutionChainDetail] = [EvolutionChainDetail]()

    @Sorted(by: \.id) var evolutionChainPokemonDetails: [PokemonDetail] = []
    
    var description: String {
        pokemonDescription?.flavorTextEntries.first?.flavorText ?? ""
    }
    
    func getAllWeaknesses() -> [String] {
        self.pokemonWeakness?.damageRelations.doubleDamageFrom.map {$0.name} ?? []
    }
    
    var height: String {
        Measurement(value: Double(pokemonDetail?.height ?? 0),
                    unit: UnitLength.decimeters).converted(to: .feet).formatted()
    }
    
    var weight: String {
        String(describing: Measurement(value: Double(pokemonDetail?.weight ?? 0) / 10, unit: UnitMass.kilograms))
    }
    
    var eggGroups: String {
        var eggGroup: String = ""
        
        pokemonDescription?.eggGroups.forEach { group in
            if eggGroup.isEmpty {
                eggGroup = "\(group.name.localizedCapitalized)"
            } else {
                eggGroup = "\(eggGroup), \(group.name.localizedCapitalized)"
            }
        }
        
        return eggGroup
    }
    
    var typeNames: [String] {
        pokemonDetail?.types.map {$0.rawValue} ?? []
    }
    
    var colors: [Color] {
        pokemonDetail?.types.map {$0.color} ?? []
    }
    
    var abilities: String {
        var abilities: String = ""
        
        pokemonDetail?.abilities.forEach({ ability in
            if abilities == "" {
                abilities = "\(ability.ability.name.localizedCapitalized)"
            } else {
                abilities = "\(abilities), \(ability.ability.name.localizedCapitalized)"
            }
        })
        return abilities
    }
    
    var genders: String {
        let genders =  ["Male", "Female", "Genderless"]
        
        if pokemonDescription?.genderRate == -1 {
            return genders.last ?? ""
        }
        if pokemonDescription?.genderRate == 8 {
            return "Female"
        }
        if [1, 2, 4, 6, 7].contains( pokemonDescription?.genderRate) {
            return genders.dropLast().joined(separator: ",")
        }
        return ""
    }
    
    func getStatItems() -> [StatItem] {
        pokemonDetail?.stats.map {
            StatItem(title: $0.stat.name, progress: Float($0.baseStat))
        } ?? []
    }
    
     func getEvolutionChainList() -> [EvolutionChain.Specie] {
        var listOfSpecies = [EvolutionChain.Specie]()
        
        listOfSpecies.append( pokemonEvolutionChain?.chain.species ?? EvolutionChain.Specie(name: "", url: ""))
        if !(pokemonEvolutionChain?.chain.evolvesTo.isEmpty ?? true) {
            listOfSpecies.append(pokemonEvolutionChain?.chain.evolvesTo.first?.species ?? EvolutionChain.Specie(name: "", url: ""))
        }
        if !(pokemonEvolutionChain?.chain.evolvesTo.first?.evolvesTo.isEmpty ?? true) {
            listOfSpecies.append(pokemonEvolutionChain?.chain.evolvesTo.first?.evolvesTo.first?.species ?? EvolutionChain.Specie(name: "", url: ""))
        }
        
        return listOfSpecies
    }
   
}
