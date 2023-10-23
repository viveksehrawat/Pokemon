//
//  EvolutionChainView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 21/10/23.
//

import SwiftUI
import Kingfisher

struct EvolutionChainDetail: Hashable, Identifiable {
    var id: Int
    var imageUrl: String
}

struct EvolutionChainView: View {

    @EnvironmentObject var pokemonDetailVM: PokemonDetailViewModel

    var body: some View {

        VStack(alignment: .leading) {
            Text("Evolution Chain")
                .font(.system(size: 20))

            HStack {
                ForEach(pokemonDetailVM.evolutionChainDetails, id: \.self) { detail in
                    ZStack {
                        KFImage(URL(string: detail.imageUrl))
                            .resizable()
                            .scaledToFit().padding(.all, 10)

                    }.frame(width: 84, height: 117)

                    if pokemonDetailVM.evolutionChainDetails.count > 1 && detail.id != pokemonDetailVM.evolutionChainDetails.last?.id {
                        Image(systemName: "arrow.right")
                            .foregroundColor(.black)
                    }
                }

            }
        }

    }
}
#Preview {
    EvolutionChainView()
}
