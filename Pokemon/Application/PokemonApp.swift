//
//  PokemonApp.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import SwiftUI

@main
struct PokemonApp: App {
    var body: some Scene {
        WindowGroup {
            PokemonListView(viewModel: generatePokemonViewModel())
        }
    }
    
    
    // below one should be in
    private func generatePokemonViewModel() -> PokemonListViewModel {
        let viewModel = PokemonListViewModel(useCase: generatePokemonUseCase())
        return viewModel
    }
    
    private func generatePokemonUseCase() -> IPokemonListUseCase {
        let listRepo = generatePokemonRepository()
        let detailRepo = generateDetailPokemonRepository()

        let useCase = PokemonListUseCaseImpl(respository: listRepo, pokemonDetailRepository: detailRepo)
        return useCase
    }
    
    private func generatePokemonRepository() -> IPokemonRepository {
        let repository = PokemonRepositoryImpl(networkManager: networkManager)
        return repository
    }
    
    private func generateDetailPokemonRepository() -> IPokemonDetailRepository {
        let repository = PokemonDetailRepositoryImpl(networkManager: networkManager)
        return repository
    }
    
    var networkManager: INetworkManager = {
        let networkManager = NetworkManager()
        return networkManager
    }()
}
