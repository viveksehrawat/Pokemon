//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 21/10/23.
//

import Foundation
import UIKit


class PokemonDetailViewModel: LoadableObject{
    
    typealias Output = PokemonDescription
    
    @Published var state = LoadingState<Output>.idle
    @Published var pokemon: PokemonDetail?
    
    @Published var pokemonDescription: PokemonDescription?
    @Published var pokemonWeakness: PokemonWeakness?
    @Published var pokemonEvolutionChain: EvolutionChain?
    @Published var detailImage: UIImage =  UIImage()
    @Published var evolutionChainDetails: [EvolutionChainDetail] = []
    
    @Sorted(by: \.id) private var evolutionChainPokemonDetails: [PokemonDetail] = []
    
    private let useCase: IPokemonDetailUseCase
    var currentIndex: Int
    var pages: [Int]
    var currentName: String
    
    init(useCase: IPokemonDetailUseCase, totalPages: Int, selectedIndex: Int, selectedName: String) {
        self.useCase = useCase
        self.pages = Array(1...totalPages)
        self.currentIndex = selectedIndex
        self.currentName = selectedName
    }
    
    var pokemonDetail: PokemonDetail! {
        didSet {
            evolutionChainPokemonDetails.append(pokemonDetail)
        }
    }
    
    @MainActor
    func load(){
        state = .loading
        Task{
            do {
                
                let itemDetail = try await self.useCase.fetchPokemonDetail(for: currentName)
                
                let pokDesc = try await useCase.fetchPokemonDescription(for: currentIndex)
                let pokWeakness = try await useCase.fetchPokemonWeakness(for: currentIndex)
                let pokEvolutionChain = try await useCase.fetchPokemonEvolutionCahin(for: pokDesc.evolutionChain.url )
                pokemonDetail = itemDetail
                pokemonDescription = pokDesc
                pokemonWeakness = pokWeakness
                pokemonEvolutionChain = pokEvolutionChain
                
                await getEvolutionChainPokemonDetails()
                
                state = .loaded(pokDesc)
                
            } catch {
                state = .failed(error)
                print(error.localizedDescription)
            }
        }
    }
    
    var description: String {
        pokemonDescription?.flavorTextEntries.first?.flavorText ?? ""
    }
    
    func getAllWeaknesses() -> [String] {
        self.pokemonWeakness?.damageRelations.doubleDamageFrom.map {$0.name} ?? []
    }
    
    var height: String {
        Measurement(value: Double(pokemonDetail.height),
                    unit: UnitLength.decimeters).converted(to: .feet).formatted()
    }
    
    var weight: String {
        String(describing: Measurement(value: Double(pokemonDetail.weight) / 10, unit: UnitMass.kilograms))
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
    
    var abilities: String {
        var abilities: String = ""
        
        pokemonDetail.abilities.forEach({ ability in
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
        pokemonDetail.stats.map {
            StatItem(title: $0.stat.name, progress: Float($0.baseStat))
        }
    }
    
    
    private func getEvolutionChainPokemonDetails() async {
        let chainList = self.getEvolutionChainList().filter { $0.name.caseInsensitiveCompare(pokemonDetail.name) != .orderedSame }
        
        do {
             try await withThrowingTaskGroup(of: PokemonDetail.self) { taskGroup in

                
                for specie in chainList {
                    taskGroup.addTask {
                            let detail = try await self.useCase.fetchPokemonDetail(for: specie.name)
                            return detail
                }
            }
                 
            for try await detail in taskGroup {
                
                    self.evolutionChainDetails.append(EvolutionChainDetail(id: detail.id, imageUrl: detail.imageUrl))
                
            }
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
    
    
    func goToNextPage() {
        currentIndex += 1
    }
    
    func goToPrevious() {
        currentIndex -= 1
    }
    
}
