//
//  PokemonListView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import SwiftUI

struct PokemonListView: View {
    
    @ObservedObject private(set) var viewModel: PokemonListViewModel
    private let adaptiveColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    func test(){
        viewModel.state = .loading
    }
    
    var body: some View {
        NavigationStack{
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
                            .padding(.bottom, 10)
                        LazyVGrid(columns: adaptiveColumns, spacing: 10){
                            ForEach(Array(pokemons.enumerated()), id: \.1.id) { (index, pokemon) in
                                NavigationLink(destination: PokemonDetailView()) {
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
        }
    }
}
