//
//  PokemonCellView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import SwiftUI

struct PokemonCellView: View {
    
    let pokemon: Pokemon
    @EnvironmentObject var vm: PokemonListViewModel
    
    var body: some View {
        
        VStack {
            thumbnailView()
            Text(pokemon.name)
        }
        .frame(height: 200)
        .background(Color(.white))
        .cornerRadius(10)
    }
    
    private func thumbnailView() -> some View {
        
        GeometryReader { geometry in
            
            let thumbURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
            
            return AsyncImage(url: thumbURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                    
                case .failure:
                    Image(systemName: "exclamationmark.icloud.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.red)
                    
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

//#Preview {
//    let pokemon = Pokemon(name: "Vivek", url: "")
//    PokemonCellView(pokemon: pokemon)
//}
