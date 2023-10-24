//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import Foundation

class PokemonListViewModel: LoadableObject{
    
    private let useCase: IPokemonListUseCase
    typealias Output = [PokemonDetail]
    
    @Published var state = LoadingState<Output>.idle
    private var pokemons: [Pokemon] = [Pokemon]()
    @Published var searchText = ""
    @Published var selectedPokemonIndex = 0
    @Sorted(by: \.id) var detailItems: [PokemonDetail] = []
    
    init(useCase: IPokemonListUseCase) {
        self.useCase = useCase
    }
    
    var filteredPokemon : [PokemonDetail] {
        if searchText == "" { return detailItems}
        
        if let searchId = Int(searchText) {
            return  detailItems.filter { $0.id == searchId }
        }else{
            return  detailItems.filter { $0.name.contains(searchText.lowercased())
            }
        }
    }
    
    @MainActor
    func load(){
        state = .loading
        Task{
            do {
                let page = try await useCase.fetchPokemonList()
                pokemons = page.pokemons
                await fetchPokemonDetails(for: page)
                
            } catch {
                state = .failed(error)
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    private func fetchPokemonDetails(for page: PokemonPage) async {
        let pokemonList = page.pokemons
        do {
            // Create a task group to fetch Pokemon details concurrently
            try await withThrowingTaskGroup(of: PokemonDetail.self) { taskGroup in
                for pokemon in pokemonList {
                    taskGroup.addTask {
                        let name = pokemon.name.lowercased()
                        let itemDetail = try await self.useCase.fetchPokemonDetail(for: name)
                        //                    print(itemDetail.name)
                        return itemDetail
                    }
                }
                
                // Wait for all tasks to complete
                for try await result in taskGroup {
                    // You can access the result if needed
                    self.detailItems.append(result)
                }
            }
            state = .loaded(detailItems)
        } catch {
            print("Error loading Pokemon details: \(error.localizedDescription)")
            state = .failed(error)
        }
        
        pokemons = pokemonList
        state = .loaded(detailItems)
    }
}

