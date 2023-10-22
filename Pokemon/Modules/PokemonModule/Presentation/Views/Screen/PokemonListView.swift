//
//  PokemonListView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import SwiftUI

struct PokemonListView: View {
    
    @ObservedObject private(set) var viewModel: PokemonListViewModel
    @State private var isDetailViewPresented = false // Add this state variable

    private let adaptiveColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
            AsyncContentView(source: viewModel) { pokemons in
                ScrollView{
                    VStack(alignment: .leading){
                        Text("Pokedex")
                            .font(.system(size: 35))
                            .bold()
                        Divider()
                        Text("Search for any Pokemon that exists on the planet")
                            .font(.system(size: 16))
                        PokemonSearchView()
                            .environmentObject(viewModel)
                            .padding(.bottom, 10)
                        LazyVGrid(columns: adaptiveColumns, spacing: 10){
                            ForEach(Array(viewModel.filteredPokemon.enumerated()), id: \.1.id) { (index, pokemon) in
                                Button{
                                    viewModel.selectedPokemonIndex = index
                                    isDetailViewPresented.toggle()
                                } label: {
                                    PokemonCellView(pokemon: pokemon, index: index)
                                        .environmentObject(viewModel)
                                }
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal, 20)
            .background(Color("backgroundColor"))
            .fullScreenCover(isPresented: $isDetailViewPresented) {
                PokemonDetailView(viewModel: generatePokemonViewModel())
            }
        }
    
    // below one should be in router
    private func generatePokemonViewModel() -> PokemonDetailViewModel {
        let viewModel = PokemonDetailViewModel(useCase: generatePokemonUseCase(), totalPages: viewModel.pokemons.count, selectedIndex: viewModel.selectedPokemonIndex + 1)

        return viewModel
    }
    
    private func generatePokemonUseCase() -> IPokemonDetailUseCase {
        let detailRepo = generateDetailPokemonRepository()
        let useCase = PokemonDetailUseCaseImpl( pokemonDetailRepository: detailRepo)
        return useCase
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
