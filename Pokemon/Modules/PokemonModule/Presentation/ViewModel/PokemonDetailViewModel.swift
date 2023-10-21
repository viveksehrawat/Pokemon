//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 21/10/23.
//

import Foundation


class PokemonDetailViewModel: LoadableObject{
    
    private let useCase: IPokemonUseCase
    typealias Output = [Pokemon]

    @Published var state = LoadingState<Output>.idle
    @Published var pokemons: [Pokemon] = [Pokemon]()
    @Published var searchText = ""
    @Published var selectedPokemonIndex = 0

    

    init(useCase: IPokemonUseCase) {
        self.useCase = useCase
    }
    
    var filteredPokemon : [Pokemon] {
        return searchText == "" ? pokemons : pokemons.filter { $0.name.contains(searchText.lowercased())
        }
    }
    
    // Get the index of a pokemon
    func getPokemonIndex(pokemon: Pokemon) -> Int {
        if let index = self.pokemons.firstIndex(of: pokemon){
            return index + 1
        }
        return 0
    }
    
    @MainActor
    func load(){
        state = .loading
        Task{
            do {
                let result = try await useCase.fetchPokemonData()
                state = .loaded(result)
                pokemons = result
            } catch {
                state = .failed(error)
                print(error.localizedDescription)
            }
        }
    }
}
