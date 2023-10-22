//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 21/10/23.
//

import Foundation


class PokemonDetailViewModel: LoadableObject{
    
    typealias Output = PokemonDescription
    
    @Published var state = LoadingState<Output>.idle
    @Published var pokemon: PokemonDetail?
    
    @Published var pokemonDescription: PokemonDescription?
    @Published var pokemonWeakness: PokemonWeakness?
    @Published var pokemonEvolutionChain: EvolutionChain?
//    @Published var pokemonDetail: PokemonDetail?

    private let useCase: IPokemonDetailUseCase
    var currentIndex: Int
    var pages: [Int]
    
    init(useCase: IPokemonDetailUseCase, totalPages: Int, selectedIndex: Int) {
        self.useCase = useCase
        self.pages = Array(1...totalPages)
        self.currentIndex = selectedIndex
    }
    
    var pokemonDetail: PokemonDetail! {
        didSet {
//            evolutionChainPokemonDetails.append(pokemonDetail)
//            image(url: pokemonDetail.imageUrl) {self.detailImage = $0}
        }
    }
    
    @MainActor
    func load(){
        state = .loading
        Task{
            do {
                let itemDetail = try await self.useCase.fetchPokemonDetail(for: currentIndex)

                let pokDesc = try await useCase.fetchPokemonDescription(for: currentIndex)
                let pokWeakness = try await useCase.fetchPokemonWeakness(for: currentIndex)
                
                pokemonDetail = itemDetail
                pokemonDescription = pokDesc
                pokemonWeakness = pokWeakness
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

    var typeNames: [String] {
        pokemonDetail?.types.map {$0.rawValue} ?? []
    }

    func getStatItems() -> [StatItem] {
        pokemonDetail.stats.map {
            StatItem(title: $0.stat.name, progress: Float($0.baseStat))
        }
    }
    
    func goToNextPage() {
        currentIndex += 1
    }
    
    func goToPrevious() {
        currentIndex -= 1
    }
    
}
