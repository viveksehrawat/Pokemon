//
//  PokemonView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 20/10/23.
//

import SwiftUI

extension Color {
    static let labelGrayColor = Color(hex: "#2E3156")
}

extension Text {
    func setForegroundColor() -> Self {
        return self.foregroundColor(.labelGrayColor)
    }
}


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
                ImageTextSectionView()
                GeneralPropertyView()

                StatsView(statItems: detail.getStatItems())
                EvolutionChainView(evolutionChainDetails: vm.pageData.evolutionChainDetails)

                GeometryReader { geometry in
                    HStack{
                        if vm.currentPageIndex != 0 {
                           AppButton(title: "Previous") {
                               vm.goToPrevious()
                           }
                        }
                        
                        Spacer()
                        if vm.currentPageIndex != vm.pokemons.endIndex - 1 {
                            AppButton(title: "Next") {
                                vm.goToNextPage()
                            }
                        }
                       
                    }
                }
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
