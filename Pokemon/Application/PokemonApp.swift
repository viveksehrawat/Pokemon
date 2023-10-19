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
    
    private func generatePokemonUseCase() -> IPokemonUseCase {
        let useCase = PokemonUseCaseImpl(respository: generatePokemonRepository())
        return useCase
    }
    
    private func generatePokemonRepository() -> IPokemonRepository {
        let repository = PokemonRepositoryImpl(service: generatePokemonService())
        return repository
    }
    
    private func generatePokemonService() -> IPokemonService {
        let service = PokemonServiceImpl(networkManager: networkManager)
        return service
    }
    
    var networkManager: INetworkManager = {
        let networkManager = NetworkManager()
        return networkManager
    }()
}
