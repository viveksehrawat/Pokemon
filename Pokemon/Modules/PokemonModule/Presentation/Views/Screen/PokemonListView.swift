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
        //        GridItem(.adaptive(minimum: 150))
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    func test(){
        viewModel.state = .loading
    }
    
    var body: some View {
       
        AsyncContentView(source: viewModel) { pokemons in
            ScrollView{
                LazyVGrid(columns: adaptiveColumns, spacing: 10){
                    ForEach(pokemons){ pokemon in
                        NavigationLink(destination: PokemonDetailView()) {
                            PokemonCellView(pokemon: pokemon)
                                .environmentObject(viewModel)
                        }
                    }
                }
            }
            .navigationTitle("Trending Movies")
            .padding(.horizontal, 10)
        }
        
    }
}

//#Preview {
//    PokemonListView()
//}
