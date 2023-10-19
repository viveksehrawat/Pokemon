//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import Foundation

class PokemonListViewModel: LoadableObject{
    
    private let useCase: IPokemonUseCase
    typealias Output = [Pokemon]

    @Published var state = LoadingState<Output>.idle
    @Published var pokemons: [Pokemon] = [Pokemon]()
    
    init(useCase: IPokemonUseCase) {
        self.useCase = useCase
    }
    
    @MainActor
    func load(){
        state = .loading
        Task{
            do {
                let result = try await useCase.fetchPokemonData()
                state = .loaded(result)
            } catch {
                state = .failed(error)
                print(error.localizedDescription)
            }
        }
    }
}
