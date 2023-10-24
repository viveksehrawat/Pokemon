//
//  PokemonView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 20/10/23.
//

import SwiftUI




struct PokemonView: View {
    
    @EnvironmentObject var vm: PokemonDetailViewModel
    
    var pokemonId: Int
    var dismiss: () -> Void
    
    var body: some View {
        
        AsyncContentView(source: vm) { detail in
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30){
                    
                    HeaderView(dismiss: {
                        dismiss()
                    }, title: detail.pokemonDetail?.name.uppercased() ?? "", number: String(format: "%03d", detail.pokemonDetail?.id ?? 0))
                    if let pokemonDetail = detail.pokemonDetail {
                        ImageTextSectionView(description: detail.description, pokemon: pokemonDetail)
                    }
                    
                    GeneralPropertyView()
                    StatsView(statItems: detail.getStatItems())
                    EvolutionChainView(evolutionChainDetails: vm.pageData.evolutionChainDetails)
                    FooterButtonView()
                    Spacer(minLength: 30)
                }
            }
            .padding(.horizontal, 30)
            .background(Color("backgroundColor"))
            .task {
                
            }
        }
    }
}

#Preview {
    PokemonView(pokemonId: 1){
    }
}
