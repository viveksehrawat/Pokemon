//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 21/10/23.
//

import Foundation
import UIKit
import SwiftUI

class PokemonDetailData {
     var pokemonDetail: PokemonDetail?
     var pokemonDescription: PokemonDescription?
//     var pokemonWeakness: PokemonWeakness?
//     var pokemonEvolutionChain: EvolutionChain?
//     var detailImage: UIImage =  UIImage()
//     var evolutionChainDetails: [EvolutionChainDetail] = []
//
//    @Sorted(by: \.id) private var evolutionChainPokemonDetails: [PokemonDetail] = []
}

enum DetailLoadingState {
    case idle
    case loading
    case failed(Error)
    case loaded
}

class PokemonDetailViewModel: LoadableObject{
    
    typealias Output = PokemonDetailData
    @Published var pageData: PokemonDetailData = PokemonDetailData()
    
    @Published var detailState = DetailLoadingState.idle
    
    @Published var state = LoadingState<Output>.idle
    
    @Published var pokemonDescription: PokemonDescription?

    @Published var pokemonDetail: PokemonDetail?
    @Published var pokemonWeakness: PokemonWeakness?
    @Published var pokemonEvolutionChain: EvolutionChain?
    @Published var detailImage: UIImage =  UIImage()
    @Published var evolutionChainDetails: [EvolutionChainDetail] = []
    
    @Sorted(by: \.id) private var evolutionChainPokemonDetails: [PokemonDetail] = []
    
    private let useCase: IPokemonDetailUseCase
    @Published var currentPageIndex: Int

    var pages: [Int] = []
    var currentName: String = ""
    var pokemons: [Pokemon]
    
    init(useCase: IPokemonDetailUseCase, selectedIndex: Int, allPokemons: [Pokemon]) {
        self.useCase = useCase
        self.currentPageIndex = selectedIndex
        self.pokemons = allPokemons
        self.pages = Array(0...allPokemons.count)

    }
    
//    var pokemonDetail: PokemonDetail! {
//        didSet {
//            evolutionChainPokemonDetails.append(pokemonDetail)
//        }
//    }
    
    @MainActor
    func load(){
        self.currentName = pokemons[currentPageIndex].name

        state = .loading
        Task{
            do {
                
                let pokDetail = try await getPokemonDetail(for: currentName)
                let pokDesc = try await getPokemonDescription(id: currentPageIndex + 1)
//                let pokWeakness = try await useCase.fetchPokemonWeakness(for: currentIndex)
//                let pokEvolutionChain = try await useCase.fetchPokemonEvolutionCahin(for: pokDesc.evolutionChain.url )
                
                pokemonDetail = pokDetail
                pokemonDescription = pokDesc
//                pokemonWeakness = pokWeakness
//                pokemonEvolutionChain = pokEvolutionChain
//                
//                await getEvolutionChainPokemonDetails()

                pageData.pokemonDetail = pokDetail
                pageData.pokemonDescription = pokDesc
                state = .loaded(pageData)
                
            } catch {
                state = .failed(error)
                print(error.localizedDescription)
            }
        }
    }
    
    func getPokemonDetail(for name: String) async throws -> PokemonDetail{
         try await self.useCase.fetchPokemonDetail(for: currentName)
    }
    
    func getPokemonDescription(id: Int) async throws -> PokemonDescription{
         try await self.useCase.fetchPokemonDescription(for: id)
    }
    
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
    
    
    @MainActor
    private func getEvolutionChainPokemonDetails() async {
        let chainList = self.getEvolutionChainList().filter { $0.name.caseInsensitiveCompare(pokemonDetail?.name ?? "") != .orderedSame }
        
        do {
             try await withThrowingTaskGroup(of: PokemonDetail.self) { taskGroup in

                
                for specie in chainList {
                    taskGroup.addTask {
                            let detail = try await self.useCase.fetchPokemonDetail(for: specie.name)
                        

                            return detail
                }
            }
                 
            for try await detail in taskGroup {
                evolutionChainPokemonDetails.append(detail)
            }
                 
                 self.evolutionChainPokemonDetails.forEach({ detail in
                     self.evolutionChainDetails.append(EvolutionChainDetail(id: detail.id, imageUrl: detail.imageUrl))
                 })
                 
        }
    } catch {
        print("Error loading Pokemon details: \(error.localizedDescription)")
        
        }
    }

    
    private func getEvolutionChainList() -> [EvolutionChain.Specie] {
        var listOfSpecies = [EvolutionChain.Specie]()
        
        listOfSpecies.append( self.pokemonEvolutionChain?.chain.species ?? EvolutionChain.Specie(name: "", url: ""))
        if !(self.pokemonEvolutionChain?.chain.evolvesTo.isEmpty ?? true) {
            listOfSpecies.append(self.pokemonEvolutionChain?.chain.evolvesTo.first?.species ?? EvolutionChain.Specie(name: "", url: ""))
        }
        if !(self.pokemonEvolutionChain?.chain.evolvesTo.first?.evolvesTo.isEmpty ?? true) {
            listOfSpecies.append(self.pokemonEvolutionChain?.chain.evolvesTo.first?.evolvesTo.first?.species ?? EvolutionChain.Specie(name: "", url: ""))
        }
        
        return listOfSpecies
    }
    
    
    @MainActor 
    func goToNextPage() {
        currentPageIndex += 1
        state = .idle
    }
    
    func goToPrevious() {
        currentPageIndex -= 1
        state = .idle

    }
    
}
