//
//  PokemonCellView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import SwiftUI
import Kingfisher

struct PokemonCellView: View {
    
    let pokemon: Pokemon
    let index: Int
    @EnvironmentObject var vm: PokemonListViewModel
    
    var body: some View {
        
        VStack {
            KFImage(URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(index).png")!)
                .resizable()
                .scaledToFit()
                .padding()
            Text(pokemon.name.capitalized)
                .font(.system(size: 18))
                .foregroundColor(.black)
                .bold()
            Text("\(index + 1)")
                .font(.system(size: 15))
                .foregroundColor(.black)

        }
        .frame(height: 250)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                .foregroundColor(.black)
        )
        .background(Color("cellBackground"))

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
