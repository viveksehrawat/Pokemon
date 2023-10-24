//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 21/10/23.
//

import Foundation
import UIKit
import SwiftUI

enum DetailState {
    case idle
    case failed
    case loaded
}

struct DetailData {
    var state: DetailState
    var data: PokemonDetailData
}

class PokemonDetailViewModel: LoadableObject{
    
    typealias Output = PokemonDetailData
    @Published var pageData: PokemonDetailData = PokemonDetailData()
    @Published var state = LoadingState<Output>.idle
    private let useCase: IPokemonDetailUseCase
    
    @Published var currentPageIndex: Int
    
    var pages: [Int] = []
    var currentName: String = ""
    var pokemons: [PokemonDetail]
    private var details: [DetailData] = []
    
    init(useCase: IPokemonDetailUseCase, selectedIndex: Int, allPokemons: [PokemonDetail]) {
        self.useCase = useCase
        self.currentPageIndex = selectedIndex
        self.pokemons = allPokemons
        self.pages = Array(0...allPokemons.count)
        details = Array(repeating: DetailData(state: .idle, data: PokemonDetailData()), count: allPokemons.count)
        
    }
    
    @MainActor
    func load(){
        self.currentName = pokemons[currentPageIndex].name
        pageData.evolutionChainPokemonDetails = []
        state = .loading
        
        Task{
            do {
                
                if details[currentPageIndex].state == .loaded {
                    pageData =  details[currentPageIndex].data
                    state = .loaded(pageData)
                    return
                }
                pageData = PokemonDetailData()// reset
                
                let detail = try await getPokemonDetail(for: currentName)
                pageData.pokemonDetail = detail
                
                pageData.pokemonDescription = try await getPokemonDescription(id: currentPageIndex + 1)
                pageData.pokemonWeakness = try await getPokemonWeakness(id: currentPageIndex + 1)
                
                pageData.evolutionChainPokemonDetails.append(detail)
                
                let url = pageData.pokemonDescription?.evolutionChain.url ?? ""
                pageData.pokemonEvolutionChain = try await getPokemonEvolution(url: url )
                
                await getEvolutionChainPokemonDetails()
                
                let newPageData =  DetailData(state: .loaded, data: pageData)
                details.insert(newPageData, at: currentPageIndex)
                
                state = .loaded(pageData)
                
            } catch {
                state = .failed(error)
                print(error.localizedDescription)
            }
        }
    }
    
    func getPokemonDetail(for name: String) async throws -> PokemonDetail {
        try await self.useCase.fetchPokemonDetail(for: name)
    }
    
    func getPokemonDescription(id: Int) async throws -> PokemonDescription{
        try await self.useCase.fetchPokemonDescription(for: id)
    }
    
    func getPokemonWeakness(id: Int) async throws -> PokemonWeakness{
        try await useCase.fetchPokemonWeakness(for: id)
    }
    
    func getPokemonEvolution(url: String) async throws -> EvolutionChain{
        try await useCase.fetchPokemonEvolutionChain(for: url)
    }
    
    @MainActor
    private func getEvolutionChainPokemonDetails() async {
        let chainList = pageData.getEvolutionChainList().filter { $0.name.caseInsensitiveCompare(pageData.pokemonDetail?.name ?? "") != .orderedSame }
        
        do {
            try await withThrowingTaskGroup(of: PokemonDetail.self) { taskGroup in
                
                for specie in chainList {
                    taskGroup.addTask {
                        let detail = try await self.getPokemonDetail(for: specie.name)
                        return detail
                    }
                }
                
                for try await detail in taskGroup {
                    pageData.evolutionChainPokemonDetails.append(detail)
                }
                
                pageData.evolutionChainPokemonDetails.forEach({ detail in
                    pageData.evolutionChainDetails.append(EvolutionChainDetail(id: detail.id, imageUrl: detail.imageUrl, colors: detail.types.map({$0.color})))
                })
            }
        } catch {
            print("Error loading Pokemon details: \(error.localizedDescription)")
            
        }
    }
    
    //    @MainActor
    func goToNextPage() {
        currentPageIndex += 1
        state = .idle
    }
    
    func goToPrevious() {
        currentPageIndex -= 1
        state = .idle
        
    }
    
}
