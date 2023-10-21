//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 21/10/23.
//

import Foundation


class PokemonDetailViewModel: LoadableObject{
    
    private let useCase: IPokemonDetailUseCase
    typealias Output = PokemonDetail

    @Published var state = LoadingState<Output>.idle
    @Published var pokemon: PokemonDetail?
    @Published var currentIndex = 0

    var selectedPokemonIndex: Int

    init(useCase: IPokemonDetailUseCase, index: Int) {
        self.useCase = useCase
        self.selectedPokemonIndex = index
    }
    
    @MainActor
    func load(){
        state = .loading
        Task{
            do {
                let result = try await useCase.fetchPokemonDetail(for: "\(selectedPokemonIndex)" )
//                state = .loaded(result)
//                pokemon = result
            } catch {
                state = .failed(error)
                print(error.localizedDescription)
            }
        }
    }
}
